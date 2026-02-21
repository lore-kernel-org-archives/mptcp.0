Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDC274FD3
	for <mptcp@lists.linux.dev>; Sat, 21 Feb 2026 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771651427; cv=none; b=GflXOFrzs/QFNzkl+0lYxeofGs3fWL/xAxszUUyGGd/mxqBjt8s/lWLQe20W0M+6j+B2FvssS0sg5QKVdRzoJ9gAfJzbKIJlA7dYO3R8fnhFUQ25zObg91a00d3zKMUH2da7+6v+V6pgzuHZJl7+j4nMgetUjESE5d2T2cBZLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771651427; c=relaxed/simple;
	bh=p/xtHdMPk1pR+VdyNY1pDhFYN4fePitbnyNh4l8YYbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiJkNRa1AgkHIRY9qSRfWULihiveDaAT33e+XfBT+2kbxWy6ZPGmCiDfRRygQPaEUuBUaG8AmL6tIeQaiR/Mc4dMzEucTM8R9mGLFEVjHMIffmCweVhCtDetKm11AhFJ0lkZIma72HXatwsutq2VXO+q2ycdSA/DANp/2o2l/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KcYFYHaB; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KcYFYHaB"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c65d772cso2526708a34.1
        for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 21:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771651424; x=1772256224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pg2SfmNcjcuUaWT9UVC8V53BPdNDRsv1m5oJtLpHbc=;
        b=KcYFYHaBd3EJ9N1H0Edaazjs9gup49oaRQdo7SZE8FPxmFpL3peFylSTGKqhshRo7s
         OzRMahSZjbVmnohLebR9ardrl755aRuU9atlDlz16voKhYU/XrNdBeKARHaVpkrVnikp
         gHUGgFfhV896+0UQ8bA/uM5lHrMNPz6TXypaPhIpYvVdMIM91q8KSUfqkEGwdPyyp9my
         bAykhRM1KtisTLB01bHnlgzcIaHUQz8YHGxWqcQH/pG6NGNJ6ub6Xwut30qH9I6yCgNi
         jotbEVmpPTl6pxCnrFAiDs1VjpdxP4r8DW7H9SkZVhKE2FGTuohL0YnSgdsRm3T5DXuJ
         bCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771651424; x=1772256224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Pg2SfmNcjcuUaWT9UVC8V53BPdNDRsv1m5oJtLpHbc=;
        b=dFYHSPXKjBv4dIohY9jFWm0p4gLDazKXNUD0W5htdjZ6mfOc4XEXZBJcsZrmQAeLU5
         vmSBM7x1jcnhFvMOfZCAkTFgsd52CneLWBYVzGkf1np9fIXozK237oOGNKZGgBGS31AF
         nrdGEAhS7r5NQD0EQDGa65zTTsYxmcTaxOIOfCje5UeO1xVT5Dx6I3Ms1dhG7c7xcSm9
         9IJxKsC+RqFbdIqAmRyY0n95IJnpreDot7WPFPhKgxk2wjxiNI3lm8uiMPlihRp/TdjK
         GqhvfNWKz5GbFriYmPbp1fqx+13XcDuYaycKrgY/AiyIM2hQPCBAD8vmLAtqs7fePsPv
         riug==
X-Forwarded-Encrypted: i=1; AJvYcCWcXQ1v/s51B/oNk6p8PncQlRqYTZBmzWS5AFBQqIkU3VYiXmNIpLPOr5ST5nEWT5umoC73UA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCgibhmtgOCkJnLv7rH1i8aUkPx7V+KIlpHV4IKH5rIifdPew8
	hCyZnBBruVcUAhQtcS4i9bbJk0XYDjes2NXoZKs4i/AW6JL1Zi4LxCl/korZ+E2ljXI=
X-Gm-Gg: AZuq6aJTYUFud1A3qQDObVeGeE6NFpj1NGbHJzqoyvZpcHa0XGxZvIUM32KVuWFfeow
	eUyQAYwG5ZJQaqCbnsbIa2XhFwLuBaiB8cG1/Es2QFt8WWDHM3/9vSUI1Nw4GhWbIeBT84jGzjv
	w0DxF82sGGYw0zeK12c5rhLv7aswtUc5vjV+Yj/C4rKhsYZFX1pzWdxq0lyEbmyuZYb//qtYy/W
	ybpzFPT0ixpE3RASYjcdJkzl+y6S0kogHt4DVZ5EmWA24NCeYtTMPUtdsiIPNL78xqNJT1tA8Eg
	HtppIvBXDtRoGDXnj1TPG0VK4GqdCrDfCeZZGeLo8YqZBRYXVE1t43bLDyArFJj484wm/AQRd1d
	Y5t/H2VW2WFq1zGKK1UmYV/FW39NzXkgm4XyEGvYJqGwfrV80rpBsWvD5oOuVB2KNcQ9d4N/oD4
	kthvdYLT1Dw2NrXa5uwKt1+Y5t8iy4cW8imvkb1iE4MKRG9TVpjEGhm6QOUjAbvC+o7kgETPipf
	QE=
X-Received: by 2002:a05:6830:2aab:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7d52beb1751mr1373900a34.1.1771651424472;
        Fri, 20 Feb 2026 21:23:44 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04e0bbsm1473746a34.24.2026.02.20.21.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:23:44 -0800 (PST)
Date: Fri, 20 Feb 2026 21:23:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 3/3] mptcp: monitor: add JSON support
Message-ID: <20260220212341.2481f496@phoenix.local>
In-Reply-To: <20260220-ipr-monitor-json-v1-3-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
	<20260220-ipr-monitor-json-v1-3-eb4b0d5f7820@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 19:54:03 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> +static void sig_exit_json(int signo)
> +{
> +	delete_json_obj();
> +	rtnl_close(&genl_rth);
> +	exit(0);
> +}
> +

Technically, none of these functions are signal safe.

Maybe an atexit cleanup function, or on_exit, or destructor.
