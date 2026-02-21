Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7330BBB6
	for <mptcp@lists.linux.dev>; Sat, 21 Feb 2026 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652345; cv=none; b=tv2mbSSDDdRc+k1U+Xy5418HEE5XojtOV1ilK0VTiBCVY8LObumVUYf4yovS5kZ5L+zrd/tn9kgDa8Myd6eFymhKwYhGCIzIjWPBPnZlHEP7KyKRsqrhIAYof/y3CUVIb2MPWp8sX3tYGBIjoJplghBID6k9g3FZuU5TWk61bpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652345; c=relaxed/simple;
	bh=ahXtCAjLyzpktbzU9Uo5EQqnUb3w3OlwKLRRzTyTsfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUb4khY+7QVccGtQNYWdtkz43+qDE1bo4MWOBm521y3e6/YpyDcr3oCDQu85heHFhcq3OWp4+TBvO2xlEeyTf5ajcZKUPOZiewLFIBkdCoy1HkqsNKu5OdLBETZ5/YfVtk3+YR+JPW7No4YecyzqW3UB+Y/ZUkfBPW8+b0AQFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PPYQrqIL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PPYQrqIL"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-897002b7576so34566656d6.3
        for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771652343; x=1772257143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCOEccdl1+Um0o8Qy8pjpdJNLvrpEJcLKiSSv8fk4VA=;
        b=PPYQrqILk7/LMgs+smLEplpplqgXsShCc3QQkc3MXa8h9+jPEZvYjCGYnxcFdN8ymD
         d0ouKGkpPJmiMGBauPSMemeY6DjxXDnSmYLPNzAzgLy0L2xbkbuf1LNUxXRkI8A9uL/e
         L+NfkzaJSbO5aOVvvCrBvskq77x9kambjpOt+w6pd/S9qIRndgDmSjLdUd95OWl2pt05
         OPYm20XwmokOX2Umt+96fTrU5gEDNqrwvfdAjWdy+n9S31HX6q9Segah647Jl6Mde08n
         qWcAbG8EyGfyZfoF7fskZlRTNDg7Mr9GtTsQxK5vUtRin8Y1vGT9DyMN4DnGODho0j3S
         ImGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771652343; x=1772257143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCOEccdl1+Um0o8Qy8pjpdJNLvrpEJcLKiSSv8fk4VA=;
        b=YPiZmkqGtTG9ywstVT3kda+LUIJ/m+Rhiui0O9DBeLM9xfXZ8I7xkwjOPdFJYsojuW
         AkjQ8dcRWUjVTl8dinhjGIUSQSqKEqBRT/w0Fz4Gvh2VIu+MPBI5xAHegP8kRfbLtVy+
         HLuzQVgYRRclNjI0zEf+bfApfieIv9uUnn+ZVRPpaA+Aj+p8sEydNVrXxE+HKFUMgNmY
         MvbSCd27IziErDqRyijnV/8OFAy2fC7J82ypLhjylG9ONuEYdL/JhfWUdH3vdHR0sWY0
         65NBTDNcgXumejyxarhNlwbWJR+WyIW0GP0sDfk/RI5FOVJGDNdb45+gwDpZpYXeNMqz
         p/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXDE+I4NTU2OtjZj0SY0vJHYZouF76qlYX3VntRYNHagQCv6/0SD/X4quRIvVS0Kkw+getRpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFNr34iqIrg74+Zc96yNNZpxvuL1VRe/4XM5+wZ8Lq2+CNIPY2
	WwhIfjcWg4hfgyutSyrRSzwpVTY3E4eX5ix1G+kalAjtPM+o+qawOV0Ttgg8NPWRjBo=
X-Gm-Gg: AZuq6aLfNjbTV/Dv+Qb8Bokw2eW4v/hcM+7Nds14sVEaZ/fF1wJCqNRowpkarjEYDbK
	UdM+RiOh8yluukhisP//ZcxphNAksFLUOPJHm31e8r/8cyhBFP53HP+WNkYmgrxjpaxNiu9vhLp
	l8ZNk9cfY9XY5s2HlY9pMMr/bNIzBkVRS5Y2SGuvMdCV9AY7NfqIg4unemdS+xybG05T+Bx6Pce
	BPGYxi+yVip25zbhqGX0J1NFO4Qz5jd1lXdKvaKeCxmJxS2fsZDierd+VYVpYSiHQT4PBcP6syP
	JmHw0wNA4cotaSk9SxVgQGHb2SRjVD2jZ/8l4t74lG9D+1hH/Or2r7AcxZZkQSok2u2cxkaPQM+
	8ShSU4y+4o+n1gchD9EuCnP8bVhNkTUAPPlhEb2hemFEwiYCigtjPY5GzYy1lBSrjDytugoZ2Q7
	v4Ut0VLij2r6oKlu+LA0xkgMW7eyy1qXMEWKq8tjvKtJdlbK9oTy6lLE0Gi+NxTzTySI6q2AvyG
	bU=
X-Received: by 2002:a05:6214:300d:b0:880:8600:efbf with SMTP id 6a1803df08f44-89979d90729mr35805436d6.56.1771652342958;
        Fri, 20 Feb 2026 21:39:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d060846sm122327385a.14.2026.02.20.21.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:39:02 -0800 (PST)
Date: Fri, 20 Feb 2026 21:39:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 2/3] utils: timestamp: add JSON support
Message-ID: <20260220213900.76198834@phoenix.local>
In-Reply-To: <20260220-ipr-monitor-json-v1-2-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
	<20260220-ipr-monitor-json-v1-2-eb4b0d5f7820@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 19:54:02 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> Only if the output stream is 'stdout', because all JSON helpers like
> print_string() only write on 'stdout'.
> 
> Supporting JSON is easy with the helpers. The biggest modification is to
> extract the end value.
> 
> No behavioural changes intended for the moment, this is a preparation for a
> future usage of print_timestamp() within a JSON context.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I would go farther, fp is always stdout. Drop the argument to the function.
