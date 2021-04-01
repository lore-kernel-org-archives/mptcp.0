Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0865F
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 06:06:05 +0000 (UTC)
HMM_SOURCE_IP:172.18.8.226:59690.1779661242
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-0cd90f328d2c4fc0a7eb9941614fe64a (unknown [172.18.8.226])
	by chinatelecom.cn (HERMES) with SMTP id 1450D280079;
	Thu,  1 Apr 2021 14:05:48 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.35])
	by filter002 with ESMTP id 0cd90f328d2c4fc0a7eb9941614fe64a for pabeni@redhat.com;
	Thu Apr  1 14:06:08 2021
X-Transaction-ID: 0cd90f328d2c4fc0a7eb9941614fe64a
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.35
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH] mptcp: ensure there is unacked data at all subflow
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, mptcp@lists.01.org, matthieu.baerts@tessares.net,
 fw@strlen.de, pabeni@redhat.com
References: <1617181038-185283-1-git-send-email-liyonglong@chinatelecom.cn>
 <c5a9ce9e-c0ca-40b7-bbc3-c7c07dcf388c@linux.intel.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <3ddcda20-7586-f74b-1856-eca18c6f4e18@chinatelecom.cn>
Date: Thu, 1 Apr 2021 14:05:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c5a9ce9e-c0ca-40b7-bbc3-c7c07dcf388c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Mat,

Thanks for your review. I will prepare a v2 patch as your suggestion.

On 2021/4/1 8:03, Mat Martineau wrote:
> 
> Hello! Thanks for your submission.
> 
> On Wed, 31 Mar 2021, lyl wrote:
> 
>> MPTCP-level retransmit may take place if first subflow
>> without data in its write queue and second subflow is likely to
>> have unacked data left in its write queue. In this condition data
>> maybe double retransmited.
>>
>> Signed-off-by: lyl <liyonglong@chinatelecom.cn>
> 
> The certificate of origin requires a full name (not initials), so could you send a v2 with your full name spelled out? See the "Developer's Certificate of Origin" section in Documentation/process/submitting-patches.rst
> 
> 
>> ---
>> net/mptcp/protocol.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 9d7e7e1..40a6703 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2072,6 +2072,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
>> {
>>     struct mptcp_subflow_context *subflow;
>>     struct sock *backup = NULL;
>> +    struct sock *idle = NULL;
>>
>>     sock_owned_by_me((const struct sock *)msk);
>>
>> @@ -2097,10 +2098,10 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
>>             continue;
>>         }
>>
>> -        return ssk;
>> +        idle = ssk;
> 
> To keep the scheduler behavior more like the existing code, can you try assigning to 'idle' only if it is NULL (has not been set to another ssk already)?
> 
>>     }
>>
>> -    return backup;
>> +    return idle ? : backup;
>> }
>>
>> static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
>> -- 
>> 1.8.3.1
> 
> -- 
> Mat Martineau
> Intel
> 
> 
