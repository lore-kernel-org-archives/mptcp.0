Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277B70
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 07:56:32 +0000 (UTC)
HMM_SOURCE_IP:172.18.8.226:44084.878307242
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-b4ad7a9888594f73833bc89de6af6c17 (unknown [172.18.8.226])
	by chinatelecom.cn (HERMES) with SMTP id ED03B2800BF;
	Thu,  1 Apr 2021 15:49:59 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.1.38])
	by filter002 with ESMTP id b4ad7a9888594f73833bc89de6af6c17 for pabeni@redhat.com;
	Thu Apr  1 15:50:04 2021
X-Transaction-ID: b4ad7a9888594f73833bc89de6af6c17
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.1.38
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v2] mptcp: ensure there is unacked data at all subflow
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>
References: <1617258890-11776-1-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwuXj1yWWyzG5FtgAr2Urg=ubQ9qLOub2dxufMjrrp7gUA@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <acc072c9-54de-095d-549a-1ceeb3beff3c@chinatelecom.cn>
Date: Thu, 1 Apr 2021 15:49:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuXj1yWWyzG5FtgAr2Urg=ubQ9qLOub2dxufMjrrp7gUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Geliang,

Got it. Thanks for your review.

On 2021/4/1 15:28, Geliang Tang wrote:
> Hi Yonglong,
> 
> Thanks for this v2, I have some comments here.
> 
> 1. There's a checkpatch.sh warning in your patch:
> 
> WARNING: 'retransmited' may be misspelled - perhaps 'retransmitted'?
> #9:
> maybe double retransmited.
>              ^^^^^^^^^^^^
> 
> total: 0 errors, 1 warnings, 0 checks, 20 lines checked
> 
> Please fix this warning in v3. And always remember to run checkpatch.sh
> before sending out a patch.
> 
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年4月1日周四 下午2:45写道：
>>
>> MPTCP-level retransmit may take place if first subflow
>> without data in its write queue and second subflow is likely to
>> have unacked data left in its write queue. In this condition data
>> maybe double retransmited.
> 
> 2. The commit log should follow the "wrap at 75 columns" rule, a maximum
> 75 chars per line. (See Documentation/process/submitting-patches.rst for
> more details)
> 
> 3. Please send out the v3 patch as a new email thread, don't reply it to
> this v2 one.
> 
> Thanks.
> 
> -Geliang
> 
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/protocol.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 9d7e7e1..66707ab 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2072,6 +2072,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
>>  {
>>         struct mptcp_subflow_context *subflow;
>>         struct sock *backup = NULL;
>> +       struct sock *idle = NULL;
>>
>>         sock_owned_by_me((const struct sock *)msk);
>>
>> @@ -2097,10 +2098,11 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
>>                         continue;
>>                 }
>>
>> -               return ssk;
>> +               if (!idle)
>> +                       idle = ssk;
>>         }
>>
>> -       return backup;
>> +       return idle ? : backup;
>>  }
>>
>>  static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
>> --
>> 1.8.3.1
>>
>>
> 
