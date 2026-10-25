Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792943935;
	b=NlekqINx/b7v0vD9vy4IpX5be5Hq7B/+9zlgnOCrwZ4AgGbtLRRyYrGH8x1EutKh9Jbl
	 iG1pU8y+x6sIFQT9zhRxZUWwnNiEMdq/qmJ0zAkPKNzQdFT4VwhyqWuSPbucglQ8jKTxG
	 zubMGJREVNCmXe1pAimvVDhVCmAsH39mdo+59lS0VsijqG+8GnlTDvLauDX62rgaUOZwK
	 kb8j7NVav46nGmGFWhLoxuymzN+kUZDNwLl4+mug6Sp3Ic+JsH8HmauPzL5kIPJIG0DBZ
	 nUt2yNua2J/JNHfGV1lgi7+8eDOlniFIlUQH0L6dDDs7GEWzOrvyyyi/vfVR2B+RJTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792943935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QjUXQ9U3FZL0zXzmfqMQXfHQBs3OYet1zCK6SBcITr0=;
	b=GVIHDcDLqQg7c2gU9a87nuCqmhEQ7uMeUTf9oP71nrO5NRbBVnj4aXwzi4ek2/pnhxZC
	 /ap3Fs/nwVnLVfv7SgZM+4ASSjdjjzeWgSDWVhY/fKE2JAfdcTPLHkAnZCnM+0jA/QR4p
	 kxeJybFS7e5212F8XyDjHgDd7OhZXG2GX+cFl5VgS1TqtHNUKZF1TWU8ozZYIkGd7q68W
	 RuZ/VyEI30IQTLRFjsN0HLKP8WDHaU+Vn6VvU1YXNoEuglj+HiYAsRPGW6wmEHy28nRTD
	 16cSEc7HZeu1p1dkILf1d+0Hb4lj5XtHR1bIHukeF0NkoOTDkMMrK8KAJ44zF5ZQLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SCm9E65V;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E5606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 15:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844E5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SCm9E65V
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so4349457eec.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792943934; x=1793548734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjUXQ9U3FZL0zXzmfqMQXfHQBs3OYet1zCK6SBcITr0=;
        b=SCm9E65VS6HlIDc87bAi4QnbD1tC51AuwFzCaCAbFN/jLUo4ZY2HcL84n5tCfrJBbr
         TA5HcR0Md1jgFnHXeGrAkzH5qfhJpOThuzsth+laVFbxLKlTxMbj4SYKIQOsONg8Rbhq
         yO1z7qhbFJA0/SRhaYUeWvKqZ9DqBVoPEb0spdd/gOTOSf2ml9Dj9dtJa+1YS9cWU0uj
         FXG+45XNlTTMeIJkaIfkxv921zqp8hvvFtKG5zSifpZpGiXGOeIzNMxmkh0heBLFVO/C
         thiTqp1+NvsdiMc/xMcuyPHFNPezsQcWjeZWtjSsL8DyOCGbJnrsP+9nri4Rkm2/jtGb
         TWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792943934; x=1793548734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjUXQ9U3FZL0zXzmfqMQXfHQBs3OYet1zCK6SBcITr0=;
        b=Y0ex6F/0IIWw69hVX36tgSNiAHup2+wEReS47bmhn+MWEv94fvrkSxUoCoV/Uo+YGG
         qlJkUT4g/LNbKlUD+6bfnXJ+IQZkMAiH0v631U8NVgJonhITtYKviMCisSVttanuTEuR
         gujM+4Bzhh04r5NulE+ryTuvL+6brhaoNGgucjnEWQwsnF3lgjRY/hEi4oWHJrjEjH/f
         dUTwUBr8hWpNcaCTXf7qmMcCSCo+VmaSymzj/nB6A7db24ehObf6eKXKdp0AdjLjuUF9
         mElqS05ll5bgWJrSKIm+Gaye++fuAJnCYagNpxMWTP2D28upQsUbERcfEkZa5SdoE4jI
         HZIg==
X-Gm-Message-State: AFq9FYLWXZ2Bf4VotMlKFgmUMyQXEBsoMYYHKo0TIgkhNYr9MUqvyDxh
	nR6O3O/6T71WxJQp0ic63YXUdJYp4hzm4K3dUnBX2wxEMuzmOZUpGOGZUBdI3g==
X-Gm-Gg: AYBFou3kiBREYf0FWFFXglIdBUpKNgKciQCWODbIRMees2JRIyAIRLVi66kChKKX9zf
	EWphhV+wjz+2rSB+v970sRF28wLLWN3GJO4NLuoxQS9IxyYQhm0Z617Ry1jLCWt59wde1Hdyjyz
	lyNcxQRs48Q4SiKrxcDnXlC4XLFSP+uxtIZgHnl04SCDrzvvGTGFtWVlSCUpLJBgDzGE7IJ3/PB
	O2x303ANDN7Rwh4HEBqSJlUahG5lz4x/t8yw4cb5gldJpE8EXkfNpFVbP8jMCxJdOyslsQyZEBE
	SGDPgZVWHa70HBM/37lrMLBKb8F+Ntt9sZVmdnkSbt5nXgw/MB1YMNUtAsP8DjVcNKJri1QlvRx
	o4YdKloaEBEsNHcDrb2kG0mAEA9ShDSeudK04MjyZyRTn7ih48HLddhWNtRd1dha+UsOXn3HKFY
	QT8NBkOSxikVVYS8tW5nnnKKF5UyR3Qd9b3lLcA2qOm03Sn97ACyfasNr9R9nGyS6elEIPtn4Sq
	Y+cg7ODKcCsRg5rVqBoUfxBqpDsQF9lNYy4PW4VcZnoD5OX/wH5+J1qOvGU
X-Received: by 2002:a05:7023:a86:b0:19a:8e3e:530e with SMTP id a92af1059eb24-19a8e3e563bmr7536055c88.8.1792943934397;
        Sun, 25 Oct 2026 08:58:54 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm16263655c88.3.2026.10.25.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 08:58:54 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Gregory Detal <gregory.detal@gmail.com>
Subject: Re: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on an idle subflow
Date: Sun, 25 Oct 2026 15:58:48 +0000
Message-ID: <20261025155848.1745712-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org>
References: <20261025134643.1537069-1-w453y.me@gmail.com> <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

I'll rebase on Shardul's series. I'll also test his v4 on my setup and
reply on that thread, since it's still waiting for reviews.

Moving it to the scheduler makes sense. The CI also caught it on v1: the
BPF "first" test saw bytes on its second subflow because of the
reinjection.

Gregory, are you still planning to continue the scheduler API series? If
not, I can pick it up. Shardul, same if you already started on it.

About once per RTT: in the old fork that limit was on the cwnd halving.
The reinjection itself only took the head of the rtx queue, when the
holder's srtt was more than 4x the idle subflow's. I'll check the cost on
fast transfers.

The perf lab would help, yes. I can share my netns cases if that's
useful.

I've fixed what Sashiko found locally, and will fold it into the
scheduler version instead of sending a v2 of this one.

Thanks,
Abdul Wasey
