Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87276259F
	for <mptcp@lists.linux.dev>; Fri,  2 Apr 2021 02:55:52 +0000 (UTC)
HMM_SOURCE_IP:172.18.8.23:46214.1082123355
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-4bdbb403c94a4406ae3e69aa2c4331e7 (unknown [172.18.8.23])
	by chinatelecom.cn (HERMES) with SMTP id D78C92800AB;
	Fri,  2 Apr 2021 10:55:38 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.35])
	by filter001 with ESMTP id 4bdbb403c94a4406ae3e69aa2c4331e7 for fw@strlen.de;
	Fri Apr  2 10:55:46 2021
X-Transaction-ID: 4bdbb403c94a4406ae3e69aa2c4331e7
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.35
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v3] mptcp: ensure there is unacked data at all subflow
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 fw@strlen.de
References: <1617263626-66920-1-git-send-email-liyonglong@chinatelecom.cn>
 <fe23f101aff3cbbe94a496374c4f7c3109d3eb2c.camel@redhat.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <2fbc7ab9-3b03-802d-afa3-935375a1191a@chinatelecom.cn>
Date: Fri, 2 Apr 2021 10:55:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fe23f101aff3cbbe94a496374c4f7c3109d3eb2c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thanks for your feeback.

On 2021/4/1 18:08, Paolo Abeni wrote:
> Hello,
> 
> I'm sorry for the late feeback.
> 
> On Thu, 2021-04-01 at 15:53 +0800, Yonglong Li wrote:
>> MPTCP-level retransmit may take place if first subflow without data in
>> its write queue and second subflow is likely to have unacked data left
>> in its write queue. In this condition datamaybe double retransmitted.
> 
> Note that the above does not cause problems at the byte stream level,
> and can improve the aggregate tput in some cases, as it could allow
> faster forward progress when e.g. the substream which originally
> handled the relevant data has experienced some congestion.
> 
> Do you have any specific scenario which is badly affected by the
> current code? How does the self-tests behave on top of this patch?
> (specifically: simult_flows.sh)

In my test, current code doesn't cause any badly affected. And in some
cases it can improve the tput in theory (re-injection likely). But the
behave of current code is not stable. In some cases it 're-injection'
data, and some cases it does not. And as you said at "Side note" the
're-injection' should not do at mptcp_subflow_get_retrans()

> 
> Side note: we could improve re-injection keeping explicit track at the
>  mptcp_data_frag level of the already used subflows, and avoding them
> at mptcp_subflow_get_retrans() time.
> 
> Thanks!
> 
> Paolo
> 
> 
> 
