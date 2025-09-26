Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EE2727E5
	for <mptcp@lists.linux.dev>; Fri, 26 Sep 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758873634; cv=none; b=YzB+lWv1OgHks/k10HQTbcb+zcEdi3GcHtQumxHEfoeyOwJ9O84+j13NXLKmjAWEI+D0Ib3CUP3Y8RrYueLNw4/4ZM9I6rQct6zx2fr4HIxgwHv4vu0x7UviprRFymrTl3QGQZa4zs24dGPLPPd3wud59RtPJA75KWPFFUvS6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758873634; c=relaxed/simple;
	bh=uKv781t5pHxGX9XHdWBHGON9HVERC0KRbzcEdEyQXDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChF08LTLmN0Vm4KoORc4HwDWXtLZpw/6eTxoYF+QGjgSbDbK8EIVBGfUD0nR31mT+TaYPdcTlIHCtz3CftsqUJpoSB9HEE+UQBOl8v6/X2lGwkWH0qnFN7d5Tih7p9PB1BprAWg4fmx1JxlcT4dr4fCux/6h/qSKTv0GORd/1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx0VmNnj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx0VmNnj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3fb179b398fso252931f8f.0
        for <mptcp@lists.linux.dev>; Fri, 26 Sep 2025 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758873631; x=1759478431; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Iu0F1mpJxkFZwruVTis8t8NuagO8uvem8I8R547GH8=;
        b=Kx0VmNnjbykPdGLrVbqvAbZwku36SVL1Ay6FroBas59tTIUWEL3Gff2RfmQslVR4ex
         1Uzf92/XNE/8My2TEPw7J6PmN9PqxlZplPsltV6igYNV/SCmV9OTdy3JD8Z6tk330nlx
         iuhqEer7jbSANRH3Lt8eeW/qi0yGX3WS+3Bd920PNUuH/2kG1K2Mheb5gwKlfzNtbQ4r
         eW4XR9hRl9W5Xg7RkGpB6+upJphK7k7oKhIWl2mt08mT8VgaZt8f1fghx3YCSx+QyusD
         NscJP9oEv7b4r605vNLSSAQQrLiUC8JRWuuhquEp4vZzqevc3Kh5pgs5v2PHxpoZsa2f
         6QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758873631; x=1759478431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Iu0F1mpJxkFZwruVTis8t8NuagO8uvem8I8R547GH8=;
        b=m8H+pYke4qFSpnYR4YBfn0oYDo1Qa76ppsN2TgbZ+8Lyj18ggfG0AZcHG+JV0MHHPY
         rj4BIOnnJrDdX3uK/EV1p1FqPXMtq+YRhdRqspiYnz9AadOvQm6JfIpHiG81MTIOmajM
         575GXNp1cJPXm9IH6O7l0rxw8L4p8NxQ54kSaRmUVwfIKoZd01IxUutu/s1uEhn7xEPc
         tIRc2/vvxqAeNZcXv8pb/tQDcmUB4c3R6flYqZjVOrnUeVSBL/V652AqNI5LBtdRgpqX
         vasuMOvg4gD2P4JVifkPNuqj9jr4P/KU3UJNHj/1y3e/9GqpAIE2JRgYlHgCAS2J94nF
         jrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2ruJEE16P+Iw33HuXIK5nv81uDLEl+ljREiDq6gPa9mPqzXJEVbDCPZzTrL5/AXfR3fBZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKUl/RbwhHIstbkIwOQKpCatgnBVB+HKg+n5siICkUBSDNyEcc
	iNYikKIi0Z/zjiW5MfoUVRWB/nzpCymWCyiVzAbG2mWz3OhUP24pYZxu
X-Gm-Gg: ASbGncvKdYLttBEUCXcTuD9O799TTVN9Bm6zSh9bkxGRQsCAzMWV10WEfKvJ/HH6I/o
	uhG2RucDmSBHyTQau9Z8zds44D4Q5AclSq/qm5VeuW9O4QUxe/rqGpRxcuGzd1GBTlgYaqKJovq
	5LuoRzzEJWshgSPndDFB/xOZyj/h04YaID9y1UOHiHy2OphaD6FdbYM65CyUC5LUCjGn06P0gIQ
	PDQ91kP/Qxpk6U5CYszPhAqPX73LIkf1vChBvUc9qy1TmjlXb3aUs0hqrrxxH+7y1Uvve4E+zKe
	eMp6ssD0fLCcQdjNzEplG9DwLBljyTArPqGJ9Y/yCrxPkXc+OG2qEdEX0CTq6u33Wt53KH24Equ
	RXvQqPttOSDcLISZhrvNNsjLPi2PH+LnkjLsGPze9
X-Google-Smtp-Source: AGHT+IHNpFF3srU1saXcXVO6zTDT4O5u6j9Vyxp4h+sviEeunSEZcOR+GiZEhHwsuD8UAwncJOuzoQ==
X-Received: by 2002:a05:6000:310d:b0:3fc:854:8b84 with SMTP id ffacd0b85a97d-40e455ca678mr3054531f8f.3.1758873630709;
        Fri, 26 Sep 2025 01:00:30 -0700 (PDT)
Received: from [172.16.20.151] ([41.229.125.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb9e1bd14sm6212872f8f.28.2025.09.26.01.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:00:30 -0700 (PDT)
Message-ID: <fcbdfd79-3996-47cb-9d91-ad049147d352@gmail.com>
Date: Fri, 26 Sep 2025 09:00:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for
 bpf selftests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
 <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <CAEf4Bzaf81OYLTzpN6E4ths_mN2gP29rMYBmbp7P2GqSMj8FbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> I see little value in these transformations. Did we catch any real
> issue here? All this type casting and replacement is just churn.
> 
> I certainly don't want such churn in libbpf, and I'd leave BPF
> selftests as is as well. int vs u64 can have subtle and non-obvious
> implications for BPF code generation (for no-alu32 variants
> especially), and I think BPF CI already exposed some of those already.
> 
> I think we can live without -Wsign-compare just fine.
> 

I was convinced by [1] that this needed to be done not just for current 
version of the code but for future code being more robust initially.I 
have already done all the work and I can follow daniel's suggestion for 
the next version.Otherwise,This means then that the TODO comment to add 
that compiler warning in the makefile needs to be removed.

Also I wanted to ask since the CI bot had success with my patch.What 
does this [2] mean exactly.

Thank you for your time reviewing and helping.

Regards,
Mehdi

[1]:https://github.com/kernel-patches/bpf/commit/495d2d8133fd1407519170a5238f455abbd9ec9b
[2]:https://github.com/kernel-patches/bpf/actions/runs/18006172526


