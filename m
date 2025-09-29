Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747B1E9B22
	for <mptcp@lists.linux.dev>; Mon, 29 Sep 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158219; cv=none; b=TahfmSchLAWYEu4QpdlvggRGi21ZTG7PYAaSFHLwu/M/XtVbSlhdWO6BuCBucGGhpo7RkvvsUo22BVCTgVtlnFeHBL1lhKzHRWbLYFTpbS1dBaD/c6SU7DDnmRXtfZJWeK2RwBqCXUFb7qVCcBYC4yMr42xWwpJrKB3lYZJUf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158219; c=relaxed/simple;
	bh=Txljvt4Nq0aTqDJEu/ZXvtErmn62T+wSfeV8ckXdBe8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UDpgnbXnDvEcH6ADDF+yxRRwEbvAsAM5EfjoQCPqYvWgsahLuRi7+sKKdaXdIsAj1uYaYu4/YOTofm+ff70p7aHxYMsj34lLt0LcVBoXmI4AdK1MqSC5wBF9Pg2xQvTSQWEtyUg5uJ+kKh19RFVwVRFuxdrJKGnfWvVuBQMZHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdxD5ry8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdxD5ry8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b2ebb73dab4so81881466b.0
        for <mptcp@lists.linux.dev>; Mon, 29 Sep 2025 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759158216; x=1759763016; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1XrYQjyYcqW6k1KsAQsJ4lFAw/seygwzewKvhwTUHM=;
        b=TdxD5ry8yjRvNDrEV4AJBSjSLoKurCJoUszbBP4g4rxHiq3i98MebEOTbl14QgWqIH
         AIqZC/VYwe1ADLKv4R5nlW4+ni5lEKnEeCcMbKKDrrQgGyfcBbKyPRznXRoJnvvVTASM
         4pfSmLTNqU1chdTsnrbHADmyuwXFTMoc1BUxmgVuHv86Q+8krMbCzNZhwbViZWLAS9MJ
         KbF1qcIXlXNlULen4wNejk2O8FmSC11B9gI76XuA2rS6HFztbTKHwEBXn+2KfUqckxcZ
         4b/Y6mSgI7IlKfDQXA3qyYM6KmzuiI045FNguCoZKjY8mRSsGHxmPUH11Lyf758DA4RM
         J4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158216; x=1759763016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1XrYQjyYcqW6k1KsAQsJ4lFAw/seygwzewKvhwTUHM=;
        b=UHZLn61RxE12rX14MWXH+DGsTnws9O55Q72v/EmH4W9Aw8uU88iyFf08NmaEDgy3lc
         r+jFWQm/o6CH4z84jo+AoCeB3EgVi44FipSFf5WMbbfC1mrPqaA7oKbKM/I4XshLowBJ
         EvK8ShWMEvFw4WLGMqThWuNuxxKUC15+DTEExc5sXsD4NEsGvAoMalGLCZwzGyEHZjZc
         jVizkEkNlsnDlg29NLfSyaBjWJLlKTXkjNrpFr0X92FJKoHqsuMYxYbTuKHaQTykVLQv
         H7ttUdFekcTCCI2D1izykyUI8zbCda8megDUfSpx/51p2Ihxo/TllUyJE6Zh5nh8sAKj
         VOpA==
X-Forwarded-Encrypted: i=1; AJvYcCXJZFM+sZkcWYkXED6ozE6EWqEl83h4u3VuwcBM+p7deXL8E7uq54xPb5hV/uxeTAiGHS4EGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy78cRYHpA89rgjHTlttjNytqJLLycc70a+MSjrdgLa6m9Tu6sE
	a0++D0ZLUNKbKS0cdDNcyFW0nMcfBlESLjk0vdBW4Zpj22jbHaPm8WCl
X-Gm-Gg: ASbGnctAQz6zVFZQrSRsOo1jk6bZwba6nEW0RvYJ+LUSV/Z4+7Pi4EnSStYH7/SexGc
	iu6SLaM8L9/NMTRWVhj7V/E5+20rMuSFsw+BusF/lfTjetzQX3UeTTmLHxkoHP1XJfQahcMBMCW
	ap+D4dBsQ2lb7cxdWRdTYXcJ2DJYBDcFQOghQRtIbJeUQaBvY7A6lXKneNPrYavOc4O4euDLGE3
	qK6AvIkio5qgfObgdfC/jF7w3ENLQRUaYRiJvRzh6KAOL0rOL25/J500VtPiJiMuQWOaoECJwd0
	eqyAsizLpQUfoxe30kBbPq1E7u++XT6md7G9zaET9EoPtOQxbxrbJVuspn0PIAGfN1Y3h2VX28v
	ne3pvxcb9lRJfidr8A5rmVtjjsULtc3LpnQVYqC9vgZZN
X-Google-Smtp-Source: AGHT+IGB16HNv+Jp1bLAOldcBF3kwkXvbqxilb33Pzgtml+xb1qiDD8br1uCM6zm8zTtfrtEl6gFPw==
X-Received: by 2002:a17:906:c14b:b0:b07:c715:1e44 with SMTP id a640c23a62f3a-b34b8999455mr944929466b.5.1759158215348;
        Mon, 29 Sep 2025 08:03:35 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.77.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3d461a411fsm309818066b.10.2025.09.29.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 08:03:35 -0700 (PDT)
Message-ID: <e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
Date: Mon, 29 Sep 2025 17:03:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
To: David Laight <david.laight.linux@gmail.com>
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
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
 <20250926124555.009bfcd6@pumpkin>
Content-Language: en-US
In-Reply-To: <20250926124555.009bfcd6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 12:45 PM, David Laight wrote:
> On Wed, 24 Sep 2025 17:23:49 +0100
> Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
> 
>> -Change all the source files and the corresponding headers
>> to having matching sign comparisons.

Hi david,
sorry for the late reply.

> 'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
> The only real way is to change all the types to unsigned ones.
The last v3 did only do that with no casting as it was suggested by 
David too.

> Consider the following:
> 	int x = read(fd, buf, len);
> 	if (x < 0)
> 		return -1;
> 	if (x > sizeof (struct fubar))
> 		return -1;
> That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
> doesn't generate an error because the compiler knows 'x' isn't negative.

  Yes,-Wsign-compare does add errors with -Werror enabled in that case 
and many other cases where the code is perfectly fine which is one of 
it's drawbacks.Also I though that because of GCC/Clang heuristics 
sometimes min() suppress the warning not because that the compiler knows 
that x isn't negative.I'm probably wrong here.
> A well known compiler also rejects:
> 	unsigned char a;
> 	unsigned int b;
> 	if (b > a)
> 		return;
> because 'a' is promoted to 'signed int' before it does the check.

In my knowledge,compilers don't necessarily reject the above code by 
default. Since -Wall in GCC includes -Wsign-compare but -Wall in clang 
doesn't, doing -Wall -Werror for clang compiler won't trigger an error 
in the case above not even a warning.My changes are to make those 
comparisons produce an error since the -Werror flag is already enabled 
in the Makefile.

> So until the compilers start looking at the known domain of the value
> (not just the type) I enabling -Wsign-compare' is pretty pointless.

I agree that enabling -Wsign-compare is pretty noisy. But it does have 
some usefulness. Take for example this code:
	int n = -5;
	for (unsigned i = 0; i < n; i++) {
     	// ...
	}
Since this is valid code by the compiler, it will allow it but n here is 
promoted to an unsigned which converts -5 to being 4294967291 thus 
making the loop run more than what was desired.of course,here the 
example is much easy to follow and variables are very well set but the 
point is that these could cause issues when hidden inside a lot of macro 
code.

> As a matter of interest did you actually find any bugs?
No,I have not found any bug related to the current state of code in bpf 
selftests but It works as a prevention mechanism for future bugs.Rather 
than wait until something breaks in future code.
> 	David
> 

Thank you for your time David.I would appreciate if you suggest on how I 
can have a useful patch on this or if I should drop this.
Best Regards,
Mehdi
> 
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> As suggested by the TODO, -Wsign-compare was added to the C compilation
>> flags for the selftests/bpf/Makefile and all corresponding files in
>> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
>> carefully changed to account for correct sign comparisons either by
>> explicit casting or changing the variable type.Only local variables
>> and variables which are in limited scope have been changed in cases
>> where it doesn't break the code.Other struct variables or global ones
>> have left untouched to avoid other conflicts and opted to explicit
>> casting in this case.This change will help avoid implicit type
>> conversions and have predictable behavior.
>>
>> I have already compiled all bpf tests with no errors as well as the
>> kernel and have ran all the selftests with no obvious side effects.
>> I would like to know if it's more convinient to have all changes as
>> a single patch like here or if it needs to be divided in some way
>> and sent as a patch series.
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa
> ...

