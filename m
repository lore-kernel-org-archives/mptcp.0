Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93D256C8D
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669571; cv=none; b=gEuG59X/u19Q3gxK5QR9YzWaprMXXt5B8PXtwnmIBcfB8F4BsDIl/vIwWPhjon+7Z7ZI7g70z01EsmL0tN4NOlHbC1Kj1kK+GW9OSDiarRL/AKd/OszdMXXqFbAteTbNWaMD84ZqBbuzhWAqKtwYWYSrxEopsscKn0FsB0zQVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669571; c=relaxed/simple;
	bh=LnxyGqM2CIWiAV/PD4VJJzYTEZrFnFNwVLDTUumld3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APCQYjtGGV0oDh6ahXo696xOYNW6vWagIOTGzaRbU2PgV3nU1xex68pEbKHM1Pg00ctBp2kNMthiso5GiB/NmaIRA4De0fiXtMtUMh8kGKWv4yO4fsPcekvAUS6WnHmRhi5f3p7wH2oyGwQLTW0nfMaYztEZyYcPMauILrsPFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ppKqJ2xW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emFYo9KG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ppKqJ2xW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emFYo9KG"
Date: Mon, 20 Apr 2026 09:19:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776669561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtSUrhXivIc5IXIWiBQF5/wpiybqYgYSDKuw7zL3g/0=;
	b=ppKqJ2xWoKBLg7OmxpfjPxOSItIVjcaiBrkcY/2PB0w99ucCEWk2m9+DvtWFj9iRLOrDfp
	ye1YQVkUQdosbBfbnDGaYzYabs0fRm7e2cclPcsxzC0Hr1HPlewvQ/fzCiTTZnGEmFWh1d
	KvUHCL56dVBNaLeKcCd6D99REO94bRFmvH7kWNyZ++o4bC0OyoWVrD5ueAzJUv1HSwfnAN
	JwW6eDYbd4CtW6NnGY+tazNSVWaoTeF/KN/6CzSs+Kf8NCKlwwfjL6EW0pVTLp7Mmcp6Yf
	fNwK/Vlamn8ACM+KQFY8F+uyiBfy/+i5yHRL8mI8RlZg8bnGUK2hjuXN7dtyrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776669561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GtSUrhXivIc5IXIWiBQF5/wpiybqYgYSDKuw7zL3g/0=;
	b=emFYo9KGcw8wQOefKtyBq5Ckc/3wJO24RTFQ6nXWkw8fl948+29BFyYWEM+m/BDDrGbJ1e
	gay19d+4P26DpvDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH] selftests: harness: fix pidfd leak in __wait_for_test
Message-ID: <20260420091719-106b0a0e-b8e5-4345-9256-e3d4586dccc6@linutronix.de>
References: <f6a4cf56c8c361d3e7373d83fd3930bd28600b4c.1776668161.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a4cf56c8c361d3e7373d83fd3930bd28600b4c.1776668161.git.tanggeliang@kylinos.cn>

On Mon, Apr 20, 2026 at 03:04:57PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>

(...)

> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 75fb016cd190..b12bc4dc3230 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1001,7 +1001,7 @@ static void __wait_for_test(struct __test_metadata *t)
>  		fprintf(TH_LOG_STREAM,
>  			"# %s: unable to wait on child pidfd\n",
>  			t->name);
> -		return;
> +		goto out;
>  	} else if (ret == 0) {
>  		timed_out = true;
>  		/* signal process group */
> @@ -1013,7 +1013,7 @@ static void __wait_for_test(struct __test_metadata *t)
>  		fprintf(TH_LOG_STREAM,
>  			"# %s: Failed to wait for PID %d (errno: %d)\n",
>  			t->name, t->pid, errno);
> -		return;
> +		goto out;
>  	}
>  
>  	if (timed_out) {
> @@ -1066,6 +1066,8 @@ static void __wait_for_test(struct __test_metadata *t)
>  			t->name,
>  			status);
>  	}
> +out:
> +	close(childfd);

I think the close() could be directly after the poll().
That would make the code simpler.

>  }
>  
>  static void test_harness_list_tests(void)
> -- 
> 2.51.0
> 
