Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55825394C
	for <mptcp@lists.linux.dev>; Thu,  2 Oct 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431654; cv=none; b=kl2f7pZ100zq2/SSopIgSEhMKIL1Lm/O7xCM+n/95fqYwq5gd656Wak6g1WFRcgA29ZHonYL8BsPFokLUeaIMljQQPB8qElPUewe7vBEKn6qstmkaaTIJPuq2/Q1Oj79TvZqO+Zj1qXG/Exhs9t1D5zZ0zmeuHOYSu8Jb/klXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431654; c=relaxed/simple;
	bh=HdRM6QtSEu6oISwiLRqfnMz+LiKeMqQ1/pBIxbMP6TM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpxjgB/ooPjgztkNHOgB2ZqxxhEJyqw+ngBre9UxHq7VFmwC7odACXGSG4+sjAENAFscKuKdujGCGsYz8TPbrm8Pd4keypKUecclD6MiCr8gPvkggAjXvIOl1hzUxhPx+SsQsk6sqhyLuv3y7Snr8qwp8KU/fpsZaL5KlbtZE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN7lv3s+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN7lv3s+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso9952405e9.1
        for <mptcp@lists.linux.dev>; Thu, 02 Oct 2025 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431651; x=1760036451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6fOaFPX2oAXf2qf/MzKaSamzMn6vecX7vKZ+f0WXRk=;
        b=XN7lv3s+XGfLthOJpw6FAiXSGXDdygt9MZ0bDwYlK9lANO/gLyb3FmzGArGdJUuSPy
         bQ5ZvHuIFRBUMmrs1Kgz/eZ1w4/vDSBvW+knFn28zXJUT01Z+mZYO8gUO6BsWAiiaP/L
         BIWVXvddF73rlQaRpLau+DtDm0xUATi/+AT4r662SmLzNkeLONyXVc9XwAoLYT6gy4M9
         UZQIgXFLoyYHiuatNOgDGKymMgj0ki5T0Xj5DhyVuh0ACFB4b9x/sI5LjMy1pY7dpQ0H
         +wZIWNAWL4B/ppyUgtgzmQJMGrply54FE9nEwEUdhznxdY8ZJh1QjBd/ypJSf3Y4BTGZ
         ZkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431651; x=1760036451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6fOaFPX2oAXf2qf/MzKaSamzMn6vecX7vKZ+f0WXRk=;
        b=V3vclqK4JOtyguYAIILg+UawHhiMtEvWkFvB2qA6qYPUm368nWnVQbDn46tmz1bssb
         vB14UEPilgPOnGGhe4HUJlC9fpCRaVt7Q5AsMWX3q8H8S/jflxABcMTv0uZuzwusNTJE
         fuBVSAuLH/F63kMkhDZIK5OGX9zjIrTOfwxiFpRF7hRK0tduJhHD3P3e8NVbdNal3uwy
         /eBfoIjALoqLzKDpG3Z+DC09lk7EUPB74NITpfOuXHwxYbOst3ukxG1y2gcskHhrvp0X
         2ylvM0ihJIrO9nlBhzWEbkK1yoLoPVcZ3EaPlQ7PvJtKD0Pa0++dMU16HO7q1Fs0CQsC
         x8zA==
X-Forwarded-Encrypted: i=1; AJvYcCU0FGOeWAO9LqnHFf0cyTymyCDVZbGOO2YOqjXhSq6xKiJuhviV5hZFpWYBZVuk8tZiIUSIyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7IfrHbdABaTS9th0cYBMm8xP2+buHqjpC2dstDRXy772OkIwE
	TWfT7reGQ8urKv8Jsp78b0Rn2brvan+skyMAQRdVjzUAB9FmmUr0rrxG
X-Gm-Gg: ASbGncup99Dafv5YJI+kiZ5knQP4Ip/FAX3TvfPibTXwg4mPuXgZ4B4sg3StT0M6LCz
	J/GerQAQ03MzUeZh3QuSjC+ARBrx9/eDp3TDDPnK/mP4GGIX2ZQEveYEjIaIRmLX7SAbbVUBBms
	Ge8A/p7fUtXMXnW+9taUKjx/WcLGXi160Pt4Ix3pzskHRv0zxrWIejZBmyZlfYqLP0fbqoFjakH
	XYXVrz89qbvO2648EFM8y9ohOhgRvPgpPenTiT/pXvLdBK6MBooHpgWb6F8XPtAp8KotssnDBJ7
	RFdluR5c82mm0C/hJhtog40CHs7t1GC3Mj7mbx/d4yIDyjbwkvPquMlROEVkN1I5l81enciFqTQ
	cYeNh5Rs8darw+eOaTuRM75DjKOeRQbx17cECgYK/Z5+1BCcIl3NQYA7t3dxdTOAxomjWxpoTa9
	6+fPgFxnJycWpi
X-Google-Smtp-Source: AGHT+IGaoHiZFJpX7P4fpJ5gN/YctPtIRaA4HuaLp2YmDRoVlK6rbZNidGIsWnYJjI0Td812wrRW+w==
X-Received: by 2002:a05:600c:83ca:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-46e70c5cef4mr4217145e9.8.1759431650257;
        Thu, 02 Oct 2025 12:00:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6918bb06sm51107905e9.8.2025.10.02.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:00:49 -0700 (PDT)
Date: Thu, 2 Oct 2025 20:00:47 +0100
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
Message-ID: <20251002200047.2b9f9ef9@pumpkin>
In-Reply-To: <e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
	<20250926124555.009bfcd6@pumpkin>
	<e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 17:03:29 +0100
Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:

> On 9/26/25 12:45 PM, David Laight wrote:
> > On Wed, 24 Sep 2025 17:23:49 +0100
> > Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
> >   
> >> -Change all the source files and the corresponding headers
> >> to having matching sign comparisons.  
> 
> Hi david,
> sorry for the late reply.
> 
> > 'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
> > The only real way is to change all the types to unsigned ones.  
> The last v3 did only do that with no casting as it was suggested by 
> David too.
> 
> > Consider the following:
> > 	int x = read(fd, buf, len);
> > 	if (x < 0)
> > 		return -1;
> > 	if (x > sizeof (struct fubar))
> > 		return -1;
> > That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
> > doesn't generate an error because the compiler knows 'x' isn't negative.  
> 
>   Yes,-Wsign-compare does add errors with -Werror enabled in that case 
> and many other cases where the code is perfectly fine which is one of 
> it's drawbacks.
> Also I though that because of GCC/Clang heuristics 
> sometimes min() suppress the warning not because that the compiler knows 
> that x isn't negative.I'm probably wrong here.

That sentence doesn't make sense.
The statically_true() test in min() uses the 'value' tracking done by modern
versions of gcc and clang.
This means it can let signed types be promoted to unsigned ones because the
compiler knows the value isn't negative.
OTOH -Wsign-compare is a much older warning and is only based on the types.

> > A well known compiler also rejects:
> > 	unsigned char a;
> > 	unsigned int b;
> > 	if (b > a)
> > 		return;
> > because 'a' is promoted to 'signed int' before it does the check.  
> 
> In my knowledge,compilers don't necessarily reject the above code by 
> default. Since -Wall in GCC includes -Wsign-compare but -Wall in clang 
> doesn't, doing -Wall -Werror for clang compiler won't trigger an error 
> in the case above not even a warning.My changes are to make those 
> comparisons produce an error since the -Werror flag is already enabled 
> in the Makefile.

This isn't about whether -Wsign-compare is enabled or not (or even what
the option is called).
It is about whether the compiler's 'sign-compare' warning triggers for that code.
The one that detects the warning/error isn't gcc or clang but is probably
used far more than clang.

> 
> > So until the compilers start looking at the known domain of the value
> > (not just the type) I enabling -Wsign-compare' is pretty pointless.  
> 
> I agree that enabling -Wsign-compare is pretty noisy. But it does have 
> some usefulness. Take for example this code:
> 	int n = -5;
> 	for (unsigned i = 0; i < n; i++) {
>      	// ...
> 	}
> Since this is valid code by the compiler, it will allow it but n here is 
> promoted to an unsigned which converts -5 to being 4294967291 thus 
> making the loop run more than what was desired.of course,here the 
> example is much easy to follow and variables are very well set but the 
> point is that these could cause issues when hidden inside a lot of macro 
> code.

There is plenty of broken code out there.
It isn't hard to find places where explicit casts make things worse.
The problem is that, even for the above example, the -5 could come from
way earlier up the code.
If you 'fix' the warning by changing it to 'i < (unsigned)n' the code is
still just as likely to be buggy.

> 
> > As a matter of interest did you actually find any bugs?  
>
> No,I have not found any bug related to the current state of code in bpf 
> selftests but It works as a prevention mechanism for future bugs.Rather 
> than wait until something breaks in future code.

That's what I expected...

> > 	David
> >   
> 
> Thank you for your time David.I would appreciate if you suggest on how I 
> can have a useful patch on this or if I should drop this.
> Best Regards,
> Mehdi
> >   
> >>
> >> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> >> ---
> >> As suggested by the TODO, -Wsign-compare was added to the C compilation
> >> flags for the selftests/bpf/Makefile and all corresponding files in
> >> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> >> carefully changed to account for correct sign comparisons either by
> >> explicit casting or changing the variable type.Only local variables
> >> and variables which are in limited scope have been changed in cases
> >> where it doesn't break the code.Other struct variables or global ones
> >> have left untouched to avoid other conflicts and opted to explicit
> >> casting in this case.This change will help avoid implicit type
> >> conversions and have predictable behavior.
> >>
> >> I have already compiled all bpf tests with no errors as well as the
> >> kernel and have ran all the selftests with no obvious side effects.
> >> I would like to know if it's more convinient to have all changes as
> >> a single patch like here or if it needs to be divided in some way
> >> and sent as a patch series.
> >>
> >> Best Regards,
> >> Mehdi Ben Hadj Khelifa  
> > ...  
> 

