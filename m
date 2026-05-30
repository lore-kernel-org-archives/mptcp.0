Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5C2F0C45
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115147; cv=none; b=Q4qxZMjVNcjgKRm/5iwnqP3E/U26dKVSTun7GIqUcBgK5zeFb7LnAz9yP1dR7ti62gSRJH6wtvOflQ+vyHabOKXtske0bcsTjlG+HosIDxcxNwW5HiquQdkXuzfW0Deh4JKdI/JneB9FLBW8G4g6uOuKGavBFZJWs1hdg7zhU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115147; c=relaxed/simple;
	bh=w0Vafz+ctaxFlIO0eixmvmca6dcavvLKttW4Bh6kKeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJqxaTf/vH5LWTFdCfbQgxpzcXg4zg3yVQpR23mJ/o+Ojy0Odl/pyCu8QAKJ/Or3oLPAJkUZGA0yTpcFAt0k4SQ+jh/Et7O+2bnC90d0NY7X9rQ56+vVmVpQ06xhObOXc4Qg/8fXkpoqlcJAuKqAt2BGLiNiZSPLxaiZUPgXTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7d0xSaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7d0xSaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4E81F00893;
	Sat, 30 May 2026 04:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780115145;
	bh=kepheXRWwdpxJMdZluauAQL5BkX5VbIU90zNJnVo4xc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L7d0xSaUyHK2FVqbCklg1AnGbsCUI5YFR/C1BGkCLoETjflZ/G2zsoGw15z3V00Gi
	 oASSz5rg9MBzBJ3udZnTKEE9/Vk41EEUHsezTD6ntvBozCrlLvZQwEawI8ofvMnqkA
	 aDp4fBWS7xgGGcfYEFZLoP5aM5jzB19rBJInjw/vQL4EIarb7TkpwXmoPTqefUr928
	 Rzsz83vu4k/hb86fowUypnnn54wXr3RWB+gAfJzdyK2/F7CnB87Punx29kLoDB3z9H
	 HK+PJIP8Aa7h2ngi1xUxl9afdm0Q+dqbeZtO5sGsds3BXxEsd52DeYxePMhbel/v1i
	 3A8cQQulHf7nQ==
Message-ID: <dccefbdd5d01b06263dca52a4197a575181803e6.camel@kernel.org>
Subject: Re: [RFC mptcp-next v22 18/20] selftests: tls: set timeout for
 multi_chunk_sendfile
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Sat, 30 May 2026 12:25:42 +0800
In-Reply-To: <abaf1bd3-58fa-4161-a1c0-18bebf4608ae@redhat.com>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
	 <1f8df4b64bc23644c48b25a8a3fc0a4ed8611cb9.1780052851.git.tanggeliang@kylinos.cn>
	 <abaf1bd3-58fa-4161-a1c0-18bebf4608ae@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2026-05-29 at 17:00 +0200, Paolo Abeni wrote:
> On 5/29/26 1:14 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The multi_chunk_sendfile test can time out with the default 30-
> > second
> > limit when run on certain configurations (e.g., MPTCP). Add a 240-
> > second
> > timeout using TEST_F_TIMEOUT to prevent failure:
> > 
> >  # multi_chunk_sendfile: Test terminated by timeout 30
> >  #          FAIL  tls.13_chacha_mptcp.multi_chunk_sendfile
> >  not ok 204 tls.13_chacha_mptcp.multi_chunk_sendfile
> > 
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Co-developed-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/tls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/tls.c
> > b/tools/testing/selftests/net/tls.c
> > index 4ae7505846f9..6f51da27ef1e 100644
> > --- a/tools/testing/selftests/net/tls.c
> > +++ b/tools/testing/selftests/net/tls.c
> > @@ -536,7 +536,7 @@ static void chunked_sendfile(struct
> > __test_metadata *_metadata,
> >  	close(fd);
> >  }
> >  
> > -TEST_F(tls, multi_chunk_sendfile)
> > +TEST_F_TIMEOUT(tls, multi_chunk_sendfile, 240)
> >  {
> >  	chunked_sendfile(_metadata, self, 4096, 4096);
> >  	chunked_sendfile(_metadata, self, 4096, 0);
> 
> Is this still required? in my tests since v8 of the stall patch I
> could
> not observe any long timeout anymore.

Thank you for the reminder. I will double-check.

-Geliang

> 
> /P
