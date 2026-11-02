Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659500;
	b=1A3tWBpoKfcDInqOVzwB6tFdi0YRwx8Jam4zmRZL/4qcrmakYalvtFkpg/9+yhnOSvoj
	 jJGcY5x6+0OjHNKVzoFvBb4nwVGeFLwhEvNedt2nAUFTjZTxQdTh25zFX3nNtCo/EJXdO
	 NWiLR6yLaSaaqy+4CGUuhv9D3H2fpYWQsum0f/zc1Aeew11yHNeBQJbwJMDBQmYubnl48
	 qfgR/TVxOmaOv2YQxtuB5Ay3vdw0QSO7JKsBUrTZ2jKh/8qeQwtCmzOQZBp58HZNBJtIz
	 I5ojqJ9U5Al5YEN3a3G3HpvfY/K49D7DGEW4GYX7CXkpSCYtJSjjtzrifd6RlDOvXEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
	b=bwtDfudRtQApIOPMxtg9BGMTiengGdXsUq2zzn9eVC37I9HOkq9EC67Kvqa6vQBjaa3g
	 J5qxZm8CgEtBLl+KNoAYLm7UvEMenGAI2vfbtdgc1PrKJIsNpeXDllXSt5NXWnoD1Beg0
	 nolPK1VaBp4g6jdyaI9nMdQBvst31pseWlkeHsr6QZS3zjf4F8Kj04uzaPQgpjG4PToH7
	 6BKafNpG7Vjdd0lcs+wHilKQtD6p6NzPBp3fmmHteqoT3+d/WMjitwyiCRKpHc/QMHWOt
	 j7x0u/N63Qtqp4xljEx6/wLzov7bPpxvM9K6BaMVvZgXBEH5CXs1ZlCRNAW789Ii7CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wYrWBF2v;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16641606A329
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 22:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16641606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wYrWBF2v
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1462688b3a.0
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659499; x=1794264299; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
        b=wYrWBF2vwGmo3N5IG9uAhC3DcpbAV+IIjAlXYx3Rm6l2TE5+0FDpdKfptPuPlXzXu1
         x56QE7a5w54Szc3LE1gzL97DrfGqXrdOw/Hu2uod0LzngzEE6PSWD7n0DWM3XQry5aPo
         zN0Hg0Qtosg3DfaNljUpADZ6tXQViv+gl5kQvVEU1MWvZtMVcTU0D5DJTPjcR/789ats
         95BquTxNu5af4hIlQaKeYEfhUs5BqAULY5fRIk10/gIW5IgLycppfU01Rf7BqvRjCzuD
         qMD/JQoX0Qo7sdoY14rtoZtljSHSJk/CLqwzUSd5E7Nnb8P8Hk21oU68hmpkYxngsIkh
         6Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659499; x=1794264299;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QmP7DYfeKMX6W+XMxlm7nFN+GTZmZT7AU7by44PL8A=;
        b=RE7zrdJlPFnEjtEKAZCLp/QOBJISNiIh2YT4UCDwzq2H5dRSWXBasgtznOZxg5aBio
         v4yOhB0cjc/BdNYCQ2VQ8DdrrXfeXaFdFCvyeB7dhFtUlPIN2kZ73+K609sk3e94+mBq
         Xfv21ZIP126ot/iWlYrri/0vrsFbmCPo+VBmRq5HO2zPBpFWtbQwoK9mJAlFhfWrfVdr
         oDCBXX5NkZa2huzhVv8YqDS2BcQrXA0bax/mhx4wrxTFtYk1A1iD+ZFAUl3PRiadPI+N
         a6lOs5fyHabjOrLDIkG0wPSVb1346vUdIvjvQEBoSu7Sygyu6YySLUBr7teX6idxfh6a
         C3zA==
X-Forwarded-Encrypted: i=1; AKwUvByyL6p+TCacbcDhfgE6/679oKGRhoTnLVYDB7YQHky/3waUqq0I6ddDqe/nNbNzOTrO96zNwg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKBWEAY3tDoluHT0VPMS+8JZ4OW2qGk0Tzhe2PLbbi39tJNTOia
	NSwIraOIjDuxM0zURMwv41/vfYX3xw3OBeSQS5y2fpjmkNJDThK6TZ+1
X-Gm-Gg: AYBFou1o27B494WYR69ZBxH9lUXM1ALNSTim2l7ikfGoV9a3Vj1ycI1QTodCgs0e/q9
	wMf6RA2DHf8uclshOlWJ8SM/bCmxQAaT7SzI1DGnc8x9nG5GhPDBBFisqJmPkP2GBN2+o847NR1
	24WZIILAt+KrerlhccJX2645KhdGHRM22t2pBdt707jFWce7vUyrnHAwF2ypopVR0x2PAs41FqE
	hQR8LdC/Ym3+BTtfclPlmRXi9vwIxIbwXtSK5qHfF5cuXbfW47BtTsr97QyfEj8qUWJ00FFQQsm
	zdy1L2DWczo7TYfPtI/W/TEYjWKUua88c8Y4rS23OpOAyykB332QA+E8aV8PvTPqLOfKgKUsd40
	s7uFlCCoESEzrfQrjl0iQJcG+lo9iZWtEffuK4L15N1PKbWLr0/gvM1jqmebXLqms+6jEn+bfgB
	bb8QT/LIpRK4ksUAHu8IiRCPd5UgUyMvW9BNL7zs3rdhdYXBB5e+COLak58TbcC41asn8sTWQC5
	/IjW8V9bp8UyF002oQez+/kuuBC8ydXJAAYqlCY4o/kWYY2R1WYmwvaK6iCzDexQFC532pB+yBQ
	uRu5AIR2NS26w78MhKvrb/u4cffAffVS2BtwZQjNidlKVP8rTf20pyWw15kgWDiPFYGg06t4Zb1
	eH88BD1LufnSOMEoq+n8gPDrCMuvt47957A==
X-Received: by 2002:a05:6a21:4e03:b0:3de:79fe:13f with SMTP id adf61e73a8af0-3e928d4d2bdmr9749200637.38.1793659499362;
        Mon, 02 Nov 2026 14:44:59 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364cb821sm358389a12.29.2026.11.02.14.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:44:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:44:58 +0000
Message-Id: <DML3865PENEX.2KBDIHWGWBJ7N@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mason@kernel.org>,
 <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "John Fastabend" <john.fastabend@gmail.com>, <mptcp@lists.linux.dev>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <tnw1v9.qyjuvdc9kq45@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <tnw1v9.qyjuvdc9kq45@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 10:51 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>+			/* A part of it may have gone out */
>>+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>>+			/* Another sender can use up the rest during the push */
>
> Interesting. We've never hit this with http parsers. We do use this to
> skip payloads some times.

That one needs two senders on one socket.
With one sender per socket you can't hit it.
A non-blocking send() fills sndbuf in the middle of the push.
N bytes go out and tcp_bpf_push() returns -EAGAIN.
Today apply_bytes still includes these N bytes.
Then the prog doesn't see the first N bytes after the payload.
There is no error and no splat, so it's easy to miss.
