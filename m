Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430816;
	b=zi6ZSEu0e4bR47Y39pqUx0RhWigLAMBFzaaZUyiXrWN0sepB5Te9OuEq2JFUuk07zQsE
	 iPsly/3PMT0PW09LmY3Py0eEaqKn3Mv4t01W4xVhRyXd934f4jrmHbdhd3r0aeNvgwjGT
	 0IEKIU+cdSedO9+5Bnlkl/vp1uNoyL8NKPvEKVysrLm6w1cbqFOtGsI+Z4Xfzj59eteGm
	 QHFTtOy0Y+ajSfVTJ0z6PhbTj+vLIWoH/ya/z5XtGwOcaE1UBA6bkQqNsEPLou0vgrXo9
	 HES6jyHZQxHZXvjEXUGlbXPZ+eXaiifxtvZilF2tFEhiCyYy/HbXXu/HPAxgII8cYcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=urUtuA7OinbrArFEjRgFaH9/8Nd3vWt4zAKhHs4kAV4=;
	b=AxxqGA4PnJfjJ3SocS2qQgWika44RYf8UKqPOGdI8McyICVRFkrfB1vSqoUg1sTacCf1
	 ngPE/Qp2oJGD43xd1U/lqzRwYumu1gyrzMjQmLYYJ4MGzZ7vmv7B5wC8lLj+e9fzXdfn6
	 UvrARoEv7UmEvyFD7BV2nKl4sN0ewVxXVHdX3N4KT69c/iIhNKvb5fWxqQu8HlOSr7GDC
	 Vi9ZNK9I6scTgS6u+aA9Ga0q/c4LmdwH6h95NjGX3dm1rkODqprvVRE/wBfLZ/Ldq0lEd
	 RLKGrBSOcfF+mlCdxZr/TooV1gnf7soELpQsu3+ifo+xj+h30+Qkootp0qq0x0W7XSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PM0UzUyC;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB8606A321
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 17:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FB8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PM0UzUyC
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35829219da8so3976072eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792430815; x=1793035615; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urUtuA7OinbrArFEjRgFaH9/8Nd3vWt4zAKhHs4kAV4=;
        b=PM0UzUyC6qLkmAJISs2Ym1hclDRC4c7mSrDCa7QLhajJPoYgsLi8yVjAaf/kDrqywR
         gsb25zb3PXesQgVqVxGb/muQ352DdNPGsAigFZN8r0qggX72MbDjHOZM0zDSFvd5Arpy
         vduTYZNwW4VGZdMeoN/BrzJuxSFh6lFdZ8y6l61kD24nxjsuph4BMURQLTa38YdhkPDS
         fEhsQcpzQGnZ5nXV18LGZvOzaVKKEkh/1/hszqxPpCneIBTlKlHnHll39ZBR/JsTxYW6
         5LoWUK+DfGgtoxi61kz9kKWLdWzYCl4nzkHg0ywlDUKZ/hkASnvw3keLEhHDlVB8DVIE
         o8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430815; x=1793035615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=urUtuA7OinbrArFEjRgFaH9/8Nd3vWt4zAKhHs4kAV4=;
        b=xRB18HnxfRxIeXzmNki0wXKgMs3TBNFg+ro9CdBhvlgB8UAoYzhEv9+jTZXcvQROyO
         LGtWvjnKNaXHVQF9E+ln4FLjFFBBm3aJPkg8NPabNBH9CQyQsClOLqQZMgmnZYod8+xd
         ug1iO/q7VvhJ+KULSC0iWdUti1yKfg/ooZqpAnCYEgzCy8KeII9g76Px2g8F+hyqNbWK
         qm1b8hqiBekCpeQPbNRAAUtIkNL8khGOJ1hlmBUaw7w2Hf/VjQvUaTWoghMr3RL+ab3Y
         K9zxKorvelojZywOJVaNIb/7q62qTrRfOlK4G3SN4fh+b9pCFARzGd7dsodY8tJQz6OW
         E2sQ==
X-Gm-Message-State: AFq9FYJg8Cnb+FpUXPjrEnyKIaTjz5l+wLo/ienSnBP5c6jFhDILO0Z1
	pPHRUAnxOPfXsh2wTuX4cHbFjgLyO84UHdbuEPtiOV5lF+b1BJCRFHN6
X-Gm-Gg: AYBFou0G8jzU+gY/afruCzs41w/rItymwT0Mksq0Tptm8Lz2LnJqaMmeftbW0L/L+7c
	9+05vNPFUTP4RoM1OXp3fmxdSfj5t6ALNJXvO1pnrFzkbkLZrmZtAgWxItUioP5aFBYDqXzU8J9
	CWm+8i+5SSguWVcevaFweQIcIb+cd4XVryEa4ktFWqMdm60YXi57uvMTLdE6gImDwUl5UUeF5Et
	saVYiQhUZKXTOfphc4fftZQFm1wHHYcZd1PZI0PDNdD6HdabsaYDOGVa6Ks/ogxs2mlkZCIILy1
	/YBZy0+BUVJTam0Ifdf1k0bEDdYEVxZVCU7zk7mVbva9fxXKnzbLsKu/MYK6k7WUV4WuOlmDvtf
	2emZJMyUXg7AGICF1FT0Cnp2fP3jTHZzl7PI9ojDF/cSXCcnq+OUAJu+a4YeqpO0JYYJL12nfh5
	Il36xf9b/ixjGTdwu1pUCerVb40V9yZpxc7JLDrwcLQo8zR31CwVSLE+99/EGvPJaY8zulw4r4R
	VAC6C4=
X-Received: by 2002:a05:701b:220e:b0:159:d448:dd1c with SMTP id a92af1059eb24-1825a67565cmr13392814c88.19.1792430814974;
        Mon, 19 Oct 2026 10:26:54 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm31725599c88.22.2026.10.19.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:26:54 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next v6 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Mon, 19 Oct 2026 17:26:46 +0000
Message-ID: <20261019172646.212143-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com> <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
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

Hi Anil,

I tested v6 on top of export (8bb146c4c) in netns: two 10 Mbit paths
with 15 ms delay, the second one blackholed with netem loss 100% in both
directions during an iperf3 transfer, tcp_retries2=3.

Upload (the client sends) works: without the series the path never
comes back, with it the path carries data again 4.5 s after it returns
for a 20 s outage, and 12.6 s for a 60 s one, the extra time being the
SYN backoff.

Download (the server sends) is not recovered. The server's subflow times
out and is freed without sending anything, while the client's subflow
on that path only receives: it stays established and idle, never gets
an error, so it is never retried. With keepalive enabled on the client
socket (idle 5 s, interval 2 s, count 3), the idle subflow times out and
your patch re-creates it: the path is back 3 s after it returns for a
20 s outage.

So for a client mostly receiving data, which is probably the common
case, the retry only helps if the application sets keepalive. Would it
make sense for the PM to probe idle subflows it initiated, or would you
rather document the keepalive requirement? I'd be happy to work on the
download case if you have a preferred direction.

With the default tcp_retries2=15, the subflows are not closed during 20
to 180 s outages, and the old ones resume by themselves 17 to 24 s after
the path returns, with or without the series.

Thanks,
Abdul Wasey
