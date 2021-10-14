Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4D2C81
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 12:17:30 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id w19so23691598edd.2
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5HgxNKXxtxSbRp8nmqih43bscnpmTJzklg2qtS+YzdQ=;
        b=AnqwX+hGdcjixLl/6uD75+7gVpUPqanCl68YXi8c2qVMDU8hFRDc4aClDkkP5Pp8vY
         Q0/RHi5tQT87lPQr3X25ThJTNBhzIyck8cNbzQb1idYk74KRBb4uI/Lff972BMwICWO5
         70E9yOTdCOy3lexnyc0U8g7pcpGlsUxQmL46m93VC5yi0hAJxrMZSGFx3ymARwmwhhSF
         RAY36vSYl7VTBSrPd8iMnIig/eY4vx4VlYI5iJz+8aE+7JWQjWkOWpTb5i3yReM8l66x
         hTte66RJqMaR7us8+15+XXEgok2WPeY5lmmv0t/hiP/IsRxBXh8Uxg90eSQK8OIInVbE
         1qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5HgxNKXxtxSbRp8nmqih43bscnpmTJzklg2qtS+YzdQ=;
        b=vGQ8JOp5MP1KgON6ahnT88K1oW8+lYtOZylPJUzPcOOY/2ENQJvbnLqXbFYOUsebDL
         5qTlFcmy0AbN6z7jYc1L8nNksc5Vx3BjzBcTjXX9hZG9OrS7cFDmljOc7EHkuteb209V
         dBFPFeQVUvg/jNjazh23mXFwkdbRtNbrr/OlqMhtooVA/wcBi/AQIJyjQVCRx6ZpL4mo
         aKLI0Fj8KzgElG57IPjvbLwO/ydMefnol2/LSGnQjmPBYdJ3nLerjxa3rCGPblqPyerA
         8c9fbPEs61h7mk0U4EHdOljQ7B7dLXGLx7kjPcpEBn8DrCN22kU5+3P0lq4vD23bj3zt
         AqhQ==
X-Gm-Message-State: AOAM530ujQ1nT7d4kN7J2cgbi0NtMwKrCyXLCPYDJp6/PnnKDUEvNyH1
	l6Qvt+gW7oV6dNUwyKeuTqgcT1Xhis9CVw==
X-Google-Smtp-Source: ABdhPJyuCPASGbnlNCznM+e7Fq8BuPc719gKEqCD7+F5sHi6x/yDFQYwoyBT7+K9nSSgCsLXFuaNhw==
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr7769908edd.103.1634213848010;
        Thu, 14 Oct 2021 05:17:28 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id t6sm2282740edj.27.2021.10.14.05.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 05:17:27 -0700 (PDT)
Message-ID: <9dd0b7e6-e2ad-b096-99f7-77468813778d@tessares.net>
Date: Thu, 14 Oct 2021 14:17:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: Avoid NULL dereference in
 mptcp_getsockopt_subflow_addrs()
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Tim Gardner <tim.gardner@canonical.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20211011235127.78924-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211011235127.78924-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Tim,

On 12/10/2021 01:51, Mat Martineau wrote:
> From: Tim Gardner <tim.gardner@canonical.com>
> 
> Coverity complains of a possible NULL dereference in
> mptcp_getsockopt_subflow_addrs():
> 
>  861       } else if (sk->sk_family == AF_INET6) {
>     	3. returned_null: inet6_sk returns NULL. [show details]
>     	4. var_assigned: Assigning: np = NULL return value from inet6_sk.
>  862                const struct ipv6_pinfo *np = inet6_sk(sk);
> 
> Fix this by checking for NULL.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/231
> Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> [mjm: Added WARN_ON_ONCE() to the unexpected case]
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for this patch, the review and the modifications!

Now in our tree: in "fixes for net", I guess that's what you wanted, right?

- 08dbe56922c1: mptcp: Avoid NULL dereference in mptcp_getsockopt_s(...)
- Results: 0c525f1e0da1..7d0aef192d20

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211014T121646

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211014T121646

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
