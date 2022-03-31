Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530D7E0
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 13:26:41 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id yy13so48127370ejb.2
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=hqdoDNIisYm23mqiDJXXKrr+XlQDy3opCbCJ8Bk+Cpo=;
        b=BmGDyCf44JFg3eDSovGZ9YzQYBuMWYdhAypoBB5lzh4cS/JU05VRxHKU4rLRZ9keP3
         kCXrRDY/+My2+XUJCxevSfMux84Uknfv+QKeod+UU/Pc2sJGAITjJsxd+64GXTTydKsT
         feDRXdnvio7eAAx+EPzbt8dU54bI2dgpaz8+VwRjlDsC4bFMbh14hRNxUHenE6lXpx8W
         um5yrv/z3utaFyCKEJBRqO04uOk+b0VWW9NaGyH2a2HjXaqezQLqFHL508PiLMj58Gh2
         VK1Pkb22gj1ippbCtidouX9kCtKOao2avhRdvgJ0W3710UcPQpacyAunhJfcVE0u5Yfl
         2IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hqdoDNIisYm23mqiDJXXKrr+XlQDy3opCbCJ8Bk+Cpo=;
        b=OhKbilV04xZFOJewxej5Ogfmo6qrn4Y2ruJ5MwGMIHFGIU6ORA6SnA7sUz0nvBCqfD
         ILm2oXfXzzP4NHkvCNmVEQeVenRulePPf+UCuA1Ix/M13Mi2oB3Xu7Wn5RfVMzaGveBz
         zJem405bF+UHxN3bppCXtjlDnYqQwDaO45APzjAqVR8dIlnOoD87phmZ1ULeBu9Ooarw
         oj69BA/fsWmrgpOKySaMouNQkF0h8rYH0+qahQFI0GQ2AnPlwLQYdAfPvvg6edPo+0yz
         Ah+I4h0nNrWSEc2oLvcAHjTVBorGzq21aZG5y2dogpMVp7QQ7UA9ZAhR2EvOfP0fAOy6
         rvrQ==
X-Gm-Message-State: AOAM530R0E9y55yLU0bGPt8tlwrPF5ukDS+OsTTeignXL64/jAL5Kjev
	C8xoAMfuBsrgQxL45LMUoDHxZQ==
X-Google-Smtp-Source: ABdhPJzOSHhW/ea4p3BHYYE7IAf6tF86xiuU+bDXz36L0EPrhz0LksJZN0+Q+xA9WApboN+Y2k0MUQ==
X-Received: by 2002:a17:907:6286:b0:6da:6e24:5e43 with SMTP id nd6-20020a170907628600b006da6e245e43mr4949822ejc.449.1648733199568;
        Thu, 31 Mar 2022 06:26:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id gb3-20020a170907960300b006dfafbb4ba4sm9724588ejc.83.2022.03.31.06.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:26:39 -0700 (PDT)
Message-ID: <15784ee7-82d2-707e-85b6-6dd294fba064@tessares.net>
Date: Thu, 31 Mar 2022 15:26:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add
 bpf_skc_to_mptcp_sock_proto" part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cd7338125a956912da5a431eef68b6849e44c0ae.1648655695.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cd7338125a956912da5a431eef68b6849e44c0ae.1648655695.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/03/2022 17:57, Geliang Tang wrote:
> Include net/mptcp.h explicitly.

Thank you for the patch!

Now in our tree:

- 5b8de9f02483: "squashed" in "bpf: add bpf_skc_to_mptcp_sock_proto"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
