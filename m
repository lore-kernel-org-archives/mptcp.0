Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48C13A258
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780192656; cv=none; b=JVVo09f94o0VwVZuPXvxjBmy8v6WLbrNt+2oFQ20rUhTCVoKZW6LHzZb8No7LqWioyENgctoDtqc+vlOgAORomlhQ5pKjVLi5h24HsWnb66skTgiwPHmifeRFpxHyJwh5+c9XID2AThpJhMfAkli7kIci/MLqQwshHN6wmgxnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780192656; c=relaxed/simple;
	bh=bLjZ0gmzFeB4+EKWD+esQ4gEDMQMdcer+6xnCHl8rII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iW0Fxq+mKgD1RQaFURtKj8WTl5hHIHq8yZllFac3w+Jt+P/oGk26rMdkvof57FU2L91cPNZE1m9Bk2V+6purPiPsJRMdtJ9AOQaSbni88PUJP7U17o35Mff+7bsueittHcXaQfSDDToOcbTldzoAuCmWFW4YNnVtONuVA8Ch76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMwJv2Jm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMwJv2Jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7D11F00893;
	Sun, 31 May 2026 01:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780192655;
	bh=oAv++cIQ5XUEIvnqK5e3i6m9q5f2uKWfJZRO1yMrWmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SMwJv2Jml0RPNcF9VjK7/FUk0RnG+HLA9SXMSRKwk6LwzCDMkno+nzjw8j2Syg8SZ
	 8RkM8fwPnjyyXTElvgznhv+bA0il6EecEZ6gWb283BHHg15axYvMFblxkwMsV1/aKm
	 iuZjUue0hNoT3D5yAdnuwNnzTsKQGkgL6olGqmQHSjLO4FO9OB14Zf0/pTtwWAbq2l
	 LUXwnKFZjyw+yhrGaLC4Gq0SKD3MuGu2jOO0+DRzrCAHdXS1k+oc/tcy2LP6ck3+U/
	 jj6PmxYubgrE96JhiY9MCEW+TS1gG8ZuAFysNbFdgJ6Fap8titvCfGO6aEdXXTRvB5
	 cY0TAmzOI+hVQ==
Message-ID: <08c1a9151d66447db2805ef0248cbface496e383.camel@kernel.org>
Subject: Re: [RFC mptcp-next v22 18/20] selftests: tls: set timeout for
 multi_chunk_sendfile
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Sun, 31 May 2026 09:57:30 +0800
In-Reply-To: <dccefbdd5d01b06263dca52a4197a575181803e6.camel@kernel.org>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
		 <1f8df4b64bc23644c48b25a8a3fc0a4ed8611cb9.1780052851.git.tanggeliang@kylinos.cn>
		 <abaf1bd3-58fa-4161-a1c0-18bebf4608ae@redhat.com>
	 <dccefbdd5d01b06263dca52a4197a575181803e6.camel@kernel.org>
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

On Sat, 2026-05-30 at 12:25 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> On Fri, 2026-05-29 at 17:00 +0200, Paolo Abeni wrote:
> > On 5/29/26 1:14 PM, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > The multi_chunk_sendfile test can time out with the default 30-
> > > second
> > > limit when run on certain configurations (e.g., MPTCP). Add a
> > > 240-
> > > second
> > > timeout using TEST_F_TIMEOUT to prevent failure:
> > > 
> > >  # multi_chunk_sendfile: Test terminated by timeout 30
> > >  #          FAIL  tls.13_chacha_mptcp.multi_chunk_sendfile
> > >  not ok 204 tls.13_chacha_mptcp.multi_chunk_sendfile
> > > 
> > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > Co-developed-by: Gang Yan <yangang@kylinos.cn>
> > > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >  tools/testing/selftests/net/tls.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/tls.c
> > > b/tools/testing/selftests/net/tls.c
> > > index 4ae7505846f9..6f51da27ef1e 100644
> > > --- a/tools/testing/selftests/net/tls.c
> > > +++ b/tools/testing/selftests/net/tls.c
> > > @@ -536,7 +536,7 @@ static void chunked_sendfile(struct
> > > __test_metadata *_metadata,
> > >  	close(fd);
> > >  }
> > >  
> > > -TEST_F(tls, multi_chunk_sendfile)
> > > +TEST_F_TIMEOUT(tls, multi_chunk_sendfile, 240)
> > >  {
> > >  	chunked_sendfile(_metadata, self, 4096, 4096);
> > >  	chunked_sendfile(_metadata, self, 4096, 0);
> > 
> > Is this still required? in my tests since v8 of the stall patch I
> > could
> > not observe any long timeout anymore.
> 
> Thank you for the reminder. I will double-check.

I ran MPTCP TLS tests on the latest v11 of 'mptcp: address stall under
memory pressure', and still infrequently encountered this timeout issue
in debug mode, so we still need this patch.

Thanks,
-Geliang

> 
> -Geliang
> 
> > 
> > /P
