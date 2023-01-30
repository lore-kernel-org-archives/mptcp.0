Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89054376
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 10:30:07 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id v10so10443857edi.8
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 02:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLLfi3OSVeysv0hMO9uy53QuJJUDBZ98D2B2HFaisls=;
        b=4qy3UO+H+pW7D5TaAB/m1oMvzpLlwwqtTOpC8HiL4WRL39QP9YTs/j9ZnwAmeCjyWH
         V7IlPrOvgby8MWrXQWMzWFhl0Te22a9ShEjFAv2tPpWz7oy7Ei5dIjDgJZsBo5OVIRzg
         5G0AnPlvczXlxnNmj0hzUElUuPCPyKwsSh/p2WUMTaLVmKJyVxZjgomPOj2qQtJPjH1j
         FBr8Trs4oO/z5+ftq52O080RTmZTtbFtEGzdSbInPIxkf/qNEnLToQ/xKaFNlMIW+ytz
         hQezM2QisgRqepOJtEZ1NadqByZpo7hKbKXHxd37YeZsjxE7wBjUUi1tSq55dhP4iS2k
         8/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLLfi3OSVeysv0hMO9uy53QuJJUDBZ98D2B2HFaisls=;
        b=WJwpxSwuTQsiRMEKdGeo2sYKmP3AbdWFnLp/YmzQKO5GtZAaxHxoqOyziSmQY7I0lj
         oZfLW7nnQ1wzuOoLTTREIRL1T79/M5Y3GiBWSsE3ojJc/KEv7WowCxphd06KdXpUqF9Y
         F7sxduvTUYgNSmFD8HvtjQvuNoXDJqppwyG5RPmn3oGEYvwRKBoZeGP/0Sh5okusgXwz
         9VArXffJlBnqpiItA+b3cnoBeRxFLtcjaogE6YrmPt9JtfKG2xCb/GJMJVGEMev7cJ0v
         dd5/ixrT6yxgitjbzkcChvkzyQ90DJ4y/0+yNHciKAcZt7rqVzvslyCXGqTiuVWRIGX3
         NyJg==
X-Gm-Message-State: AO0yUKWZ4Z5IADoXFEF8qKwU/Z/CU9hQQLU6mDVF45HuwnZifITTHRLY
	bcOZGKp53PMpso20YxfMOjD9uY2p3roaJNaj7Gc=
X-Google-Smtp-Source: AK7set8Tlm4LBKxZvQXkvDTKsw5ZbnAr/JnBSIIe288zkMRydcfbSJ/CSom6ECGDS17vMP/87J6Gpw==
X-Received: by 2002:a05:6402:28a5:b0:4a2:254f:6b1a with SMTP id eg37-20020a05640228a500b004a2254f6b1amr8570990edb.11.1675074605326;
        Mon, 30 Jan 2023 02:30:05 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ee36-20020a056402292400b004a21c9facd5sm4091917edb.67.2023.01.30.02.30.04
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 02:30:04 -0800 (PST)
Message-ID: <88e3ca28-9976-58ee-91df-1ce18da83af8@tessares.net>
Date: Mon, 30 Jan 2023 11:30:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-others-next] mptcp: bpf: Pass const struct bpf_prog
 * to .check_member
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230130102608.1278837-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230130102608.1278837-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 30/01/2023 11:26, Matthieu Baerts wrote:
> Adapt our code to a recent API change in BPF, see the Fixes tag.

I forgot to mention the goal is to squash this in "bpf: Add
bpf_mptcp_sched_ops" commit.

I just applied it there to have the CI stop complaining:

- 2282363eec43: mptcp: bpf: Pass const struct bpf_prog * to .check_member
- Results: b1869910a6c3..a9e99450a0dc (export)

I guess no other modifications are needed as the modified function is
doing nothing for the moment.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
