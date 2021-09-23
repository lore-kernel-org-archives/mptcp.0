Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75973FC8
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 16:38:38 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id i21so453373ejd.2
        for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aey5872q+oLYhIKZiZcsPptHKsGuYB409YGNJFbX47k=;
        b=0Adi90cjicgJC7uP89aHGXUTxgOnsxd+EKqa6qjnUtCi/iF+SCrkngVWjQUZhAqKSp
         ZlIE80jJs1vghZxwA12/j5y9uY9vV+LRrEvFJCjEdLv0G0fUSpsZV2JAVRexOUx9O4h8
         n9l6lZRhlEfrrTeI4MW/IHRApNRvC3v4PhgqBEs9IP8/HAvKOG7VFX1E6uLEChdtT2Hv
         LXCEeo21VeVXszahmogwPNLKiiPyP0W1idaG0L1t9fbr26NXlopAcG7xNuW9uCGs+7hO
         bnj9qTbtpFb4uj2u1LjMPwDGyRMIj4w0OvfySvad1hXxeNnpICxGzkbq4qxIZyP1kWfZ
         4txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aey5872q+oLYhIKZiZcsPptHKsGuYB409YGNJFbX47k=;
        b=it1D8YXgJyjz4V2mrXE6/ANVDJTSc8spprEb38RI/+mDkmhkIUxVmemBSUc2Td6rcD
         EngMOLd2Wef5NqUQe0AqXYtB2+Dem1iOtjvEEl3GY8Z1MsS3m0R0mj90PfLDK7mS0wNl
         Q+DWgMPwwKYeuXExEzl9qSn34E0KAUDip0upJ9gzTVNQtFdX7SZacE/xjhTgwNG1z4//
         T5drDWbjIVZ/M8Bev4RPWvB0HYuhmPsdBlslbxtceh497sdMCykVlCpSxCDq7j0BsHV0
         wrqXlLl653PieuS0wHt5oPKYqToaJ66d91NWmtt5qeVO9exFPtzN886mHpLp0y+woV8F
         hvrA==
X-Gm-Message-State: AOAM530l7LGe8gWK5+yQr9x3Mrl7cgIPpD5yvgPtKJqC3DPSxEEneL/L
	+2x/KtoeVNSbthw2+5Da7MxyXg==
X-Google-Smtp-Source: ABdhPJw6N6WsDxt6M9Yl/rMQDUKoWWrNKJtRFM8iy79ugCfjIUgqxBVvnLQG5LIUQIUmVqw4wCP8yA==
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr5972655ejd.568.1632415117273;
        Thu, 23 Sep 2021 09:38:37 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id b14sm3863160edy.56.2021.09.23.09.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:38:36 -0700 (PDT)
Subject: Re: [PATCH mptcp-net v2] mptcp: allow changing the 'backup' bit when
 no sockets are open
To: Davide Caratti <dcaratti@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <6fada33a17044e54f0ba5b3a5dc35987cbea3b54.1632318877.git.dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8f14543b-6e01-b06d-9ab0-156c954f1417@tessares.net>
Date: Thu, 23 Sep 2021 18:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6fada33a17044e54f0ba5b3a5dc35987cbea3b54.1632318877.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Davide, Mat,

On 22/09/2021 15:56, Davide Caratti wrote:
> current Linux refuses to change the 'backup' bit of MPTCP endpoints, i.e.
> using MPTCP_PM_CMD_SET_FLAGS, unless it finds (at least) one subflow that
> matches the endpoint address. There is no reason for that, so we can just
> ignore the return value of mptcp_nl_addr_backup(). In this way, endpoints
> can reconfigure their 'backup' flag even if no MPTCP sockets are open (or
> more generally, in case the MP_PRIO message is not sent out).
> 
> Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Thank you for the patch and the review!

Now in our tree (fix for -net)!

- 060daf584b27: mptcp: allow changing the 'backup' bit when no sockets
are open
- Results: eb5a9ba15e16..b84c295b0ad7

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210923T163816
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210923T163816

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
