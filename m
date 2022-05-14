Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225E393
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 16:31:20 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id fd25so786966edb.3
        for <mptcp@lists.linux.dev>; Sat, 14 May 2022 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3y3z5+F8rBSQDElkXduhZJO5UOF1bJknve6rcjFsO1I=;
        b=xA9VbCMEJ75zZF+JSp5fH7O7FWkjDXdOED7XmZEo1mPysTZsKf5WmxwLHvtKmjrELO
         0wiKn+hu8U2/5/+5c7aFyHtzhMUH4+x5Fm5X3DQkTFKrzbwP0n/kPAaObDP2L3+f9k9F
         hRB8IcLAYJJ/XQyQCD5SgGxF6krxb8K59pxjC4ZffwtUq+tfqMI4TPnhk8l+Zn2gn/8y
         RnKRTmLXdAy0YJec/o9aJIBLoPu4kp7eSTABVhJNVPjk031XRGXjZ/8g4Ex4YdHVkBh+
         6KWdDnyue3+LuGpM/E7k4e4q/v8uyu3ncp+4ofq63emzFh6y7yMp31w0OSmJ4HP/NIK2
         PA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3y3z5+F8rBSQDElkXduhZJO5UOF1bJknve6rcjFsO1I=;
        b=xQ2f2+IPmtQoE+Qv8g5mXem2cSNgo3inPT1zCfh2Bff2m07ia1S/ZOk7JJvaDG96zy
         dD3vVxh3eQGKu4i5jHaqOsmBpLoqDeE3jEkzGyci9WjHMy99pZxmlgd09qj1JsaTtlJl
         NlWVZKnci6owssM/4NdOedz/V/GxRmu66tl/WHVIeTma6/diDN1MjsEJ8JmmISIUR21e
         BilPLTwqk82hD/edryvKTn1n9DMy9XtlO9tIXzPdH0AfY9KpaST+oE+0ANl55wwiVHL5
         DZ5be6x5q1nOzm8gM2oQoIWoImtlLugDuvgAt6rXi796kY1YPGdxa2WsWNaP1ABKlqOw
         oqIw==
X-Gm-Message-State: AOAM531TZYUYJZHMvnrbZnh149UX5daQp/d2shCVZLdiQVoeIQVZ3etO
	auKP+sFLw8qy7aSJBfmvjhlpTA==
X-Google-Smtp-Source: ABdhPJyogkzY1bwXNq84218LBZT3LuUTCvrdNHs5FuSEGs6P2CSgj/pY3ObloctgGZ+xmvXn9mCSwg==
X-Received: by 2002:a05:6402:11cd:b0:427:bda5:542f with SMTP id j13-20020a05640211cd00b00427bda5542fmr4614046edw.290.1652545878849;
        Sat, 14 May 2022 09:31:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4aeb:7d32:49c3:8dac? ([2a02:578:8593:1200:4aeb:7d32:49c3:8dac])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090602cd00b006f3ef214e1asm1831547ejk.128.2022.05.14.09.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 09:31:18 -0700 (PDT)
Message-ID: <f697c655-618e-841c-4f60-3c57078e4a76@tessares.net>
Date: Sat, 14 May 2022 18:31:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <cover.1652255615.git.geliang.tang@suse.com>
 <8f2755bc-4c52-9837-c0db-2b620d7a3b22@tessares.net>
 <20220514154845.GA4189@bogon.HOST>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220514154845.GA4189@bogon.HOST>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/05/2022 17:48, Geliang Tang wrote:
> On Sat, May 14, 2022 at 01:25:35PM +0200, Matthieu Baerts wrote:
>> Hi Geliang, Mat
>>
>> On 11/05/2022 09:56, Geliang Tang wrote:
>>> v2:
>>>  - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andrii)
>>>  - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & Andrii)
>>>
>>> base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
>>> net-next-next") on export/20220510T054929
>>>
>>> v1:
>>>  - drop bpf_mptcp_helpers.h (Andrii)
>>>  - patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat)
>>
>> Thank you for the patches.
>>
>> I *think* everything is now sync in our tree but feel free to check
>> because I had to "manually" compare patches with what was in our tree.
>>
>> But in theory, our tree is now ready for a v5.
> 
> Thanks Matt, but three patches still need to be updated:
> 
> Patch #4, selftests/bpf: test bpf_skc_to_mptcp_sock
> 
> if (!tcp_sk->is_mptcp) {
> 
> ->
> 
> if (!is_mptcp) {

Thank you, I missed that!

- a973ee164a70 tg: fix wrong merge conflict resolution

> Patch #10, mptcp: add sched in mptcp_sock
> 
>  struct mptcp_sock {
>  	struct inet_connection_sock	sk;
>  
> -	__u32		token;
> -	struct sock	*first;
> -	char		ca_name[TCP_CA_NAME_MAX];
> +	__u32			token;
> +	struct sock		*first;
> +	struct mptcp_sched_ops	*sched;
> +	char			ca_name[TCP_CA_NAME_MAX];
>  } __attribute__((preserve_access_index));
>  
> ->
> 
>  	__u32		token;
>  	struct sock	*first;
> +	struct mptcp_sched_ops *sched;
>  	char		ca_name[TCP_CA_NAME_MAX];
>  } __attribute__((preserve_access_index));

I did that on purpose, I thought it was clearer to read after.

Do you prefer not to change the alignment?

> Patch #13, selftests/bpf: add bpf_first scheduler
> 
> bpf_mptcp_helpers.h
> 
> ->
> 
> bpf_tcp_helpers.h

Thanks!

- fc2aafca4737: bpf: use bpf_tcp_helpers.h instead of the mptcp one

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
