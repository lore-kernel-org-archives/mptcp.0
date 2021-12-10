Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C92C80
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 09:58:30 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id r11so27705730edd.9
        for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 01:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nduhBFxPbxmifYpnO0eOOP3C7nxBPTbeIwjsdCqiSCo=;
        b=ojvvj0K+k6NKnozWLW2tDWy91766MZb9YsUkZZD84yq8yaH1DnzCgRGc4zW9CR+Z3E
         2vs+BSinUml6Qjyb0MbBrOgsHOui0a02cPy0cqrIUgGcPho1kK21Vv6AOKU4syfzyGr6
         ZSM2KKARJ2O3WXBsrc+VrUfgJgi8GAHaVHe2HKB+OvOoTqxMHIykUz6SEjjyVYLDofUT
         4tkWQHYJ8a7xdoQKOL1TGvS9bCMzyhfSxCNiEPqsSQMJYT0YND2DBanJfy4thrcjQpsv
         NGVyKnbVO76+lE4LNwOMA8eTPqYUhFTsWhY12krSk4lNc2nU/54euf2N4eePg1MzmHYj
         PSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nduhBFxPbxmifYpnO0eOOP3C7nxBPTbeIwjsdCqiSCo=;
        b=lyq2dPN4UEI+PLZNSqaJIyLUcB+wHmyBLPq+sIJqSD62Qb81+KmPDO4h8F7JQAdeTv
         kLqd2sEyfI+yWWmDNeZuFoZS+34xX9AipbQBvX9R2jWbc2AEBeXp0AoQm0REGqHEahPT
         PlkGPmQ1egFOiwWAXNeu8i1fkGeWUFZKu+NBrX+5hu9r1TdShYYLY0N5bz0R3AVHgtsW
         Fddsr7kLDWuwHULqC3v3ooUthSad+tuD8fuJDVHFHCCcokibWNRA0XtLFFb2ADNG+WjS
         vV5Lpo1L4exkoeKwRBdnjOQkWQpXDM31uHRcY6hkwEZCdXnvDsVorS0Qkes/5dZ0FtNU
         oQog==
X-Gm-Message-State: AOAM532X1ls6kqeoQ5a+YuPF5vYA0VpRLxIY3rBAJe+4sGsHSyyQIMoD
	LQcD9EUASPS920K8ysZg7MVEfA==
X-Google-Smtp-Source: ABdhPJylHws71T7EEEhue6UdCGoV/k4VWRPPxYHA0zXkEHzMN0zoHH6zuGQNrntdBPyvVA4MsSkOUQ==
X-Received: by 2002:a17:907:7f2a:: with SMTP id qf42mr23268059ejc.388.1639130308873;
        Fri, 10 Dec 2021 01:58:28 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id co10sm1129754edb.83.2021.12.10.01.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:58:28 -0800 (PST)
Message-ID: <ab84ca1f-0f43-d50c-c272-81f64ee31ce8@tessares.net>
Date: Fri, 10 Dec 2021 10:58:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] selftests: mptcp: remove duplicate include in mptcp_inq.c
Content-Language: en-GB
To: cgel.zte@gmail.com, mathew.j.martineau@linux.intel.com
Cc: davem@davemloft.net, kuba@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ye Guojin <ye.guojin@zte.com.cn>, ZealRobot <zealci@zte.com.cn>
References: <20211210071424.425773-1-ye.guojin@zte.com.cn>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211210071424.425773-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ye,

On 10/12/2021 08:14, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> 'sys/ioctl.h' included in 'mptcp_inq.c' is duplicated.

Good catch, the modification looks good to me:

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>


This patch is for "net-next" tree as it fixes an issue introduced by a
patch only in this tree:

Fixes: b51880568f20 ("selftests: mptcp: add inq test case")

Regarding the commit message, please next time include the Fixes tag and
mention for which tree it is for in the FAQ [1], e.g. [PATCH net-next].


@David/Jakub: do you prefer a v2 with these modifications or is it fine
to apply this small patch directly in net-next tree?


Cheers,
Matt

[1] https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html
Please check the "How do I indicate which tree (net vs. net-next) my
patch should be in?" section.
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
