import { Result, Button } from 'antd';
import router from 'umi/router';

function NoFoundPage() {
  return(
    <Result
      status="404"
      title="404"
      subTitle="Sorry, the page you visited does not exist."
      extra={
        <Button type="primary" onClick={() => router.push('/')}>
          Back Home
        </Button>
      }
    />
  );
}

export default NoFoundPage;