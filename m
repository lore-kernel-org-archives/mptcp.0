Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD72DC790
	for <mptcp@lists.linux.dev>; Fri, 26 Sep 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887162; cv=none; b=ri0bRnmjRS4GRuSRgrP99Jn59gz5uA1boojGdNg4QTWHnHN+FTle0Pfiq3T4jXJvV1mbGIB5BXW8aEkIsLOCy7t+8V5K1vG55/MAXO4j7VvNRbancdUffLscxlZhj+sJz/IEoxj57SCNfFaH9Qnl47mAOGT8aYYFOHxva5Et5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887162; c=relaxed/simple;
	bh=1id3B6Wi8UowOcZ+9wbUIN5SOAeHkmeYMI59q8iHO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSD0fxEGlu3gA1xc3UJbahX4TvOjo9XWW3NNpFnQ2E8yuWLN9BPo3owvFpKqYJmxgNosssu2/0MbhiaSXne2xdkjCPuWRkXfOAec9rZUTKVp7gqDVKRJ05mWquxIR66707wxfuevE/iuM427qqoZR1y1pZD/LokADTi4geguLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0zENm5T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0zENm5T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e430494ccso593265e9.1
        for <mptcp@lists.linux.dev>; Fri, 26 Sep 2025 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758887158; x=1759491958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=G0zENm5TIPJfeHmYnhOUgEFSzbZIES5ZQM9V9bOAhL/FtQ/0/bbowGdmWLxFz1Vir1
         Xqw/ZDk+e6CfWEXEhQeFL/da87db1P8ld68c77Z7lsHA3xSv//D4KMnM/43OvSNb8z12
         zpQ5Jd1nFtjBzbwxCWSUrH196LzCHGS1lOtDdXJWPSJj2mAjk+oYWRv0pCHfGK/Qo/u6
         wWF7G/GY4mPS/B+JJEXY5laN6e0YOTtR7ilAm2E7CSprw8g/xAKHy1bPlmXyT/bgXjmG
         peF2FqTtZUcTDaNxOdmmTCnoKasDD2QyyEd3C8Sd54dR4qxZeT/ujPotShI43jhlPOVr
         fHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887158; x=1759491958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkRDFqbG55HD/5PHsPObmdh+Ov28CTpaGeY2bB6QWYU=;
        b=M0q4t18HW38D4jJljoBdIveXn4x74ARcJg/NOAyeo8fAN3x1+k1MVlz1RosCv/GeB8
         ea1GhLQWCimWAp09OiTRpAdrdX8CCmwBDsF8+96KBOR8Di6aY/CDsy5AB/0QAf2BHaO3
         bSEbR7deAxCepi1p0OYCHhIYDiREA2UV6YjoR8XL5ksC+UGz05fjg4zeeSBKETqVzXdW
         9BsMMbJ1+pXEM0V8qJ2HxLZ5Au1YAggTc8S0aZec/3OxXMngq0HJ6nXcmqhDjA1Rde2N
         mcd9LHP9rMhkorZl+Lit3OC+T2V7DPUyMZaAa/6jAdtPA+jADpkNcQKTn0HcIYXKh5PE
         1zTA==
X-Forwarded-Encrypted: i=1; AJvYcCUZju36dMZ8yCU8G6FjGD0pFKsne20tD/tEegoTC3JGBx+FzNEn8r8mE1hzIpJHkWAxmaLdAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIqMCFSuDHi6/J7DIcl3tQ3QSYSMtHo5b8ubK3xHTDnrsXACqQ
	LSw1mZNXZjT96ThdaXxV1rxVGPch++WjcJONYitL4RnWhU7SHWIJ7ILM
X-Gm-Gg: ASbGnctKlC43yysEKmCBjAZ75xsjnCI5NmpaQNGyOFOeiRAlxKvQERY5U/+vf9juCui
	rGfcddogJkcoP/vctv1tV3x7dKNusUVixlbsgZxRGIY2cTiCgCxK+7maGWUCzh7yolVqW2gJCbS
	oh2omF89bmwKOPqVbcn/leeTJ9WDi8dWQgKjj9E9JQBc8RoF+tqLgIDwTF5ah4SneWy8PrFDHYD
	gCslDD8fJ+m5nb4CXPwEz82ZA4ekxXBCdQqKMPBJ4f/sJLxC0poAV4+z7Mpv/3RY90LM3XSFi7E
	4M1Baxc1c9ctZ+lzr/OeHxzKUs9PmGMd+gKgRhu+yRJu0951VN6ulaR2darZkvPv9EvHtThNvQM
	+yKA+k36KvfNIUESKzE/afv1xKmYyeYUrU0JlDKWg95d3jT/zvqlMSDWQKS6mjxUX
X-Google-Smtp-Source: AGHT+IEPTFDb685fmiqtI/zbxG32d7v3MRP+VRk71KQ8OOHsQCWx3c0SFbrsAeMCnBPznWcIWNgGnA==
X-Received: by 2002:a05:600d:15a:20b0:46e:1e31:8d06 with SMTP id 5b1f17b1804b1-46e329f62b4mr74383735e9.16.1758887158355;
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm37380245e9.5.2025.09.26.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:45:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 12:45:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux@jordanrome.com, ameryhung@gmail.com, toke@redhat.com,
 houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com,
 isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz,
 memxor@gmail.com, vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
Message-ID: <20250926124555.009bfcd6@pumpkin>
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:23:49 +0100
Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:

> -Change all the source files and the corresponding headers 
> to having matching sign comparisons.

'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
The only real way is to change all the types to unsigned ones.
But it is of questionable benefit and make the code harder to read.

Consider the following:
	int x = read(fd, buf, len);
	if (x < 0)
		return -1;
	if (x > sizeof (struct fubar))
		return -1;
That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
doesn't generate an error because the compiler knows 'x' isn't negative.

A well known compiler also rejects:
	unsigned char a;
	unsigned int b;
	if (b > a)
		return;
because 'a' is promoted to 'signed int' before it does the check.

So until the compilers start looking at the known domain of the value
(not just the type) I enabling -Wsign-compare' is pretty pointless.

As a matter of interest did you actually find any bugs?

	David


> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> As suggested by the TODO, -Wsign-compare was added to the C compilation
> flags for the selftests/bpf/Makefile and all corresponding files in
> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> carefully changed to account for correct sign comparisons either by
> explicit casting or changing the variable type.Only local variables
> and variables which are in limited scope have been changed in cases
> where it doesn't break the code.Other struct variables or global ones 
> have left untouched to avoid other conflicts and opted to explicit 
> casting in this case.This change will help avoid implicit type 
> conversions and have predictable behavior.
> 
> I have already compiled all bpf tests with no errors as well as the
> kernel and have ran all the selftests with no obvious side effects.
> I would like to know if it's more convinient to have all changes as
> a single patch like here or if it needs to be divided in some way 
> and sent as a patch series.
> 
> Best Regards,
> Mehdi Ben Hadj Khelifa
...
