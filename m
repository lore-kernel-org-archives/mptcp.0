Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098124;
	b=FxQAUfOwP6hX7w/FUuD2Ds5qeZQe7w4Gs/dwKyPfHFwvZaIYDbf6QVZzkurr8keNP1MX
	 OtRWwrKt/QWU/yZy1GRFJliIrh8WoRM3W5JeYHWZ5pG3bNW0QnNiXHbbUTAeSjbQauqGK
	 E0mxf3aa2PTr8DOrhzlFtrmSimWCPg5AJmN45fLIO1vJisj1wJCHlxivfQgLvPWv57dr+
	 rsp6QH68ezAwk39DfPMJXJzO6w+k3EL3owMQCyJ8YOk5vfqgJPG2X3dDHtJzt+2pxlBxS
	 bNgOF31TQQxNaol6BY/oFc43r+XgP1ft8H+Kyprx+bB+jeDmvidecSpz7wbATM2RU9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098124;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=U1cepPgL8ocXNiqY3I3OLJlzorEx1NCp7eA7ucFDP7s=;
	b=nShr4AN/JXfPWUSjR6888pg7Q3kjn99/OHccDlmVJcYwrCnJnHuZZtbfCPd9T+lzqwBl
	 vHGGjCI8+5BrnZ2uYhVMU+PPYJWnKfXK/hk+kCzwrIt4HqMDr0+3+lZpgZ7W3ruueEwOu
	 Na6Szhlah9XyPAX/ktyB5zRH7iXYrBoATrHYAXSHqlCGJIDlBeu4Y5ThErxw0dUOSrYxw
	 3AIiC5oOgXlJlJlqa1wUitFUrsdEet1/POQPSSn7WvvDNeoHHz2U10OZaxWDX8B4/o1fl
	 39MmHWkXR66y/YOJnmi+7uju8LBqk0iQThvRsD9SmfFMh/BbtvOu049AWd0oPnkpUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFMGcLEr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCB5606A31E
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFMGcLEr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388921F01825;
	Tue, 27 Oct 2026 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098124;
	bh=U1cepPgL8ocXNiqY3I3OLJlzorEx1NCp7eA7ucFDP7s=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=ZFMGcLErFGsYvmOC5+4PkPe5vYYRvvf1JGBv1Du2ryZXZBIwRBERveufAk8W0eN1Y
	 YplX3Czc63RN58eDOsKQkCzCdA7ZVsJXCVGe4DQVjW3Spz13G9UWmnxiB2O+6DGluD
	 6ucd53z50UflN6gb54OxNImO0jakm0hOB4Mk+Kkyr+QlOMP3Di9SJVP7hPExbfch9C
	 QLRH8XAFmcCuh1dIk//FLTupQOXR8jZnOCRtpWjSEmgTPKKlp71Z5qN0anloqw+VRl
	 RnXalNqqInCZ1GH3LKt4cFPpYj1xKUjjBTY/GSOC8y8mHv4Q3Vu8oOvPQaAMHI4B1n
	 y+0bwi9MqPwKg==
Message-ID: <cee29410-ef2b-408e-8311-866b878da4f9@kernel.org>
Date: Tue, 27 Oct 2026 11:48:41 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: push queued data on passive TFO
 subflows becoming established
Content-Language: fr
To: T S RAMESHKUMAR <rameshsv06@gmail.com>
References: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
 <179193667256.3135.13011798294766264196@kernel.org>
 <964aeab4-7974-4a84-a391-65a00da9de72@kernel.org>
 <decee37e-e60d-4703-9b10-c8ce35c3f78e@kernel.org>
 <CADRhS2to+Z-ZztOpfYhum5z4jXkUHFhnQL3+nVBJHJxe3NZjZw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Petar Sakic <petar.sakic@ink.fish>,
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADRhS2to+Z-ZztOpfYhum5z4jXkUHFhnQL3+nVBJHJxe3NZjZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi T S,

On 22/10/2026 04:29, T S RAMESHKUMAR wrote:
> Yes, I am working on it. 
> 
> I planned that the fixes that the commit has been made on the Friday 22
> Oct 2026 

I'm sorry for this reminder, but everything is still OK on your side?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

