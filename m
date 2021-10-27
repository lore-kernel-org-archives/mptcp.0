Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C952C87
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 10:47:52 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id m17so8438605edc.12
        for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=JDT9rPHlVfbSJ+liUvqv4kYrMPkG4E0FdOgBPzE2DYY=;
        b=TDTlXttcmR5DMT94ogtjkR4Pm+QyRVUZK7iYJWsAcyh55yK7OWi2dc9KfCl+6eLhbt
         mqMSdmVZ5cYp7CYDXxTLPxm7F18qc3rWdI0YSipArlRrYN4/rqnwU7OjmLtfE1C7ghvt
         JBQ8blhUkKvtlAe1DabSyGxeKVPAOxlq0EGQOFmjTRFbMP9zWBbfZN+Mte7rhQYOuqPW
         JK6waefd9KRvHh4EpArgT4JcqM+vVdoChGqZzKO0TWK62RyCkRaRn4GMNhZ+jE8W6KNo
         rZOkVsQKI0xVYQhMv7EpJCCs8dl4kbBkPONLOrhZ9XGDC1YFJp2NaI5hyNPp0uXAYQDg
         eVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JDT9rPHlVfbSJ+liUvqv4kYrMPkG4E0FdOgBPzE2DYY=;
        b=UCFKhH3DFcbgkzqKVVS75UBiZKbpoTjCObHdkkptZCcwe90eDe5CREVPwzopTtJd0i
         DufGYI9v4SDP4wmb9JOT3/tygLvcb866Ct668VJuOBd2D9jvcTrfSm7gm7rG3fLgiIOR
         M9H/kq8qWBztJddABeGeQ81lfpXB4fz68mt7J3DTtT0nqMCFNiIG7oTKmbUugXxeNsZr
         4e23MT6A/wBensgOvZr4tAY6W4tsXTXDe4on/ZV9pNut6xvvFGN8JTQatyZCDXEwIxKK
         OPW+tSdBqQ23B9rj8MjzSSPtaZzHVDHJzHGZMgXaiYeTxue1FQ2U7x+Ibz3zob20pm6p
         bH8g==
X-Gm-Message-State: AOAM53094HLTZPJChNpgIOPdIzLxGL4PnvfNUTt3f93U4keRXlU275db
	UcAQoDzJvj/6OUSuSZtTVSgr5uVgx3+A73lx
X-Google-Smtp-Source: ABdhPJwIs0LlzIlNwpcHM3kn8yT50ZojYQ6CstSd9oV8JsXEYnmtgifmg810xPVbVp4N89ojmBk6PQ==
X-Received: by 2002:a17:906:a041:: with SMTP id bg1mr37859304ejb.470.1635331670483;
        Wed, 27 Oct 2021 03:47:50 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id e6sm6212635ejs.112.2021.10.27.03.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 03:47:50 -0700 (PDT)
Message-ID: <a0fcc873-c6aa-9d17-302e-bae59a20630c@tessares.net>
Date: Wed, 27 Oct 2021 12:47:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: selftests: mptcp: add mp_fail testcases: Build Failure
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
 <4474733d-0a7e-1ddc-d05d-9a9cdaa9ace5@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4474733d-0a7e-1ddc-d05d-9a9cdaa9ace5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/10/2021 12:32, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.

Please ignore this. The build was OK but when trying to publish the
results on Patchwork, an error happened because Patchwork didn't proceed
the patch yet.

In other words, patchew + build were faster than Patchwork.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
