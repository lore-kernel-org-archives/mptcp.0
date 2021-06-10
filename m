Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0F70
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 03:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=FnB6s
	ag0ov0UDgFDwtxYtPLQ0a4rS4DLYwAYwSqE0bo=; b=AOp9AvrrCW/CRgmOGpPbd
	Dx0m9Jg7GF5mDoI4r3ThWzsINAVsZc/OuTxzxOLmNEQTU/pfiPBEqX37yVgTDElZ
	YRep5rns5I6Z2KZa/Sb7B7lWAkXjanZicxHxFpXnG7gCNYZ9SHZKV1Es0+G97oMt
	8znNkLBBCCl7xhxRKdqHHk=
Received: from [192.168.16.78] (unknown [110.80.1.45])
	by smtp7 (Coremail) with SMTP id C8CowADX3mbKhsFgOFLEhA--.18136S2;
	Thu, 10 Jun 2021 11:28:11 +0800 (CST)
Subject: Re: [PATCH 2/3] mptcp: remove redundant req destruct in
 subflow_check_req()
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
References: <6747dc58-0dbf-b4d3-e084-85816ad5caec@163.com>
 <c23b378662b4036a1c3fca3ac994970fd503875f.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <0e1170b8-bf59-6a1c-b08e-7d06ee47f1f7@163.com>
Date: Thu, 10 Jun 2021 11:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c23b378662b4036a1c3fca3ac994970fd503875f.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowADX3mbKhsFgOFLEhA--.18136S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5Jr1rGrWfCw4Uuw18AFb_yoW8tF43pr
	s8X3WYyrsxZa4akF4rJr4DZr9Iga1SvFn8GryF9a43Jrn0qwn3KFyUWF4UuFyayF4kKayf
	GF4DtFnxX3ZF9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyoGQUUUUU=
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNwutkFWBkwNv1QAAs-

Hi Paolo,

On 2021/6/9 22:23, Paolo Abeni wrote:
> On Wed, 2021-06-09 at 18:39 +0800, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> In subflow_check_req(), if subflow sport is mismatch, will put msk,
>> destroy token, and destruct req, then return -EPERM, which can be
>> done by subflow_req_destructor() via:
>>   tcp_conn_request()
>>     |--__reqsk_free()
>>       |--subflow_req_destructor()
>> So we should remove these redundant code, otherwise will call tcp_v4_reqsk_destructor()
>> twice, and may double free inet_rsk(req)->ireq_opt.
> 
> _if_ I read the above correctly, there is no duplicated test, we should
> just drop the destructor invocation otherwise we could not enforce the
> sport check?!? am I missing something?!?

Sorry, I don't quite understand, I think the sport check is untouched by this patch.

> 
>> Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>>  net/mptcp/subflow.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 6b1cd42..75ed530 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -213,11 +213,6 @@ static int subflow_check_req(struct request_sock *req,
>>  				 ntohs(inet_sk(sk_listener)->inet_sport),
>>  				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
>>  			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
> 
> 
>> -				sock_put((struct sock *)subflow_req->msk);
>> -				mptcp_token_destroy_request(req);
>> -				tcp_request_sock_ops.destructor(req);
> 
> I mean: we just need to drop the above line.
> 

subflow_req_destructor() will do sock_put((struct sock *)subflow_req->msk)(if subflow_req->msk not NULL),
mptcp_token_destroy_request(req) and tcp_request_sock_ops.destructor(req).

>> -				subflow_req->msk = NULL;
>> -				subflow_req->mp_join = 0;

and subflow_req->mp_join won't be used again, so can drop all this five lines?
let tcp_conn_request()->__reqsk_free()->subflow_req_destructor() do this?

Thanks,
Jianguo

>>  				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
>>  				return -EPERM;
>>  			}
> 

