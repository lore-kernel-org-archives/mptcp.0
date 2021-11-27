Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226A2C81
	for <mptcp@lists.linux.dev>; Sat, 27 Nov 2021 10:03:53 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id t5so49223581edd.0
        for <mptcp@lists.linux.dev>; Sat, 27 Nov 2021 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=1eL27Eufv5yFfxEJhfzdN/qHrsGymNs42XXku5pydVg=;
        b=2g4f41hdH22XLDQqjY2p+b/m1DAMWM9s+XHEF9+iVceVDPfdfzGpAz5r8y0qASWfUI
         wh6wwpk1vmamNqnRWIj2tJS5JNiVbQch744sBV8rmcMRnvDaz6Cg3luqpaWwbLbUDJdz
         J7bamBFwh5LI6DinkxaeSCxSNVYy634Col39rK6+4SorHmXnyk8J+7cvwDQRmzzwI7fw
         jd8dXvYCX5QERvjKBQcEPVUtjfUt81aZDQEfVg3f1g1tBIgnQC0qpeDJbewcv85Eiq9f
         pUd40jwA4FdB/hdg241/9So12/juD6mkuNoc645lhLiJDwubUdFBJPWU4g45IcAjVUMW
         atqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=1eL27Eufv5yFfxEJhfzdN/qHrsGymNs42XXku5pydVg=;
        b=nY8vvNGvZYPpPstwLRws8V+yvm4qw7pZiSvtspXsS/LCC5MFQ1iXaxAkZxHs8yLDQx
         Bh8DHcZNdXaBTeeLd/CBHtLmo7WIt+zL18BBmAIDfRTLmRmTNVy172/OehCbX433Jdar
         7HWXaOn0OLF744P03VV0RvRJy/f91buaGEt7guOnET6muAPwLb+gbE0++YXoR5BTxPfw
         GXnIiszXuPxXVqwa6CK3wF4qC0vIsVYP5JHh2sgSbVbRAmMTJQiqK/qs0peMmUIT3tb/
         tmO6fJl8E2GbwYEJNFUpoz6rfdO5inIB74aSTH4joAw8Za3UUYBaq2jVQPsFQ7DEtogc
         nXug==
X-Gm-Message-State: AOAM533IKdKDMPd8gKKMudWIazi1qphf2yRkbeHDk7CoZRCWDDRJBgWS
	/oDFC5aSuAgvn/yiMDqioLGsmA==
X-Google-Smtp-Source: ABdhPJyCJ95wO4Skc/uaCteMV/d3LD6FU2HNVW7P+/TeNP7TB/4Jb+L81USES11UrF0N9UfyERuxGw==
X-Received: by 2002:a17:906:b2d0:: with SMTP id cf16mr45102942ejb.52.1638007431781;
        Sat, 27 Nov 2021 02:03:51 -0800 (PST)
Received: from [192.168.178.33] (213.211.136.227.static.edpnet.net. [213.211.136.227])
        by smtp.gmail.com with ESMTPSA id w5sm5970431edc.58.2021.11.27.02.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 02:03:51 -0800 (PST)
Message-ID: <cd39b3ab-b491-ee1d-9ba2-e47799d61e1f@tessares.net>
Date: Sat, 27 Nov 2021 11:03:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 1/2] mptcp: send MP_FAIL with MP_RST
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1637630218.git.geliang.tang@suse.com>
 <2ba9856233bd45ffe99f01566c2772b0dd12a501.1637630218.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2ba9856233bd45ffe99f01566c2772b0dd12a501.1637630218.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

+cc: Paolo

On 23/11/2021 02:23, Geliang Tang wrote:
> As described in RFC8684, 3.7 Fallback:
> 
> '''
> Therefore, it is not possible to recover the subflow, and the affected
> subflow must be immediately closed with a RST that includes an MP_FAIL
> option (Figure 16), which defines the data sequence number at the start
> of the segment (defined by the Data Sequence Mapping) that had the
> checksum failure.
> '''
> 
> MP_FAIL could be sent with MP_RST at the same time.
> 
> This patch fixed it.
> 
> Fixes: c3b546f7292ac ("mptcp: implement fastclose xmit path")

I bugged a bit when looking at your patch because I was not able to see
the issue on -net nor net-next. But then I noticed this patch is in fact
a Squash-to patch :)

Then good catch to have seen that before upstreaming these patches!

But then, I'm not sure this modification is enough: in
mptcp_write_options(), it looks like MP_FASTCLOSE and MP_RST are
mutually exclusive, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
