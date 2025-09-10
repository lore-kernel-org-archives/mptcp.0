Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4681256C83
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475106; cv=none; b=LoYi6IB5X8zKDSOqTZEPdh+9QUhGOgcYqjGiT4gYBdUCS7ygWBVYC4pdriQfw4WGz3FOFH/OsXGETe86a6e/ROjlQdqYn2j/qgdtxo6Q//4u3+rUCPGoPoCY2yT1fHO+EoCsji2t/2VTrAI6YXzkcR3bF5v1l4Q6+/4RxtE1r14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475106; c=relaxed/simple;
	bh=ysgrI8aV/Vr/i0N1KdFNWe6h9puazYMrJCspP6RXV+8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJxhAFn5Pg7vnUpVZAHXwR6Lq8Tn6fhggrNTR43oe0GWT1Y76iUs8FHrenB9wVrmiWgzEFLJVh1WDrLvTWxHgi42oecDZ0m1V3RDcY0jICQxnVes7e6/Q3JzgdkVTZNibU7uwSmiziw6fBoH/7y0emzxkKik5o93OGnCeJFn3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm/1ffd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm/1ffd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA52EC4CEF5;
	Wed, 10 Sep 2025 03:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757475105;
	bh=ysgrI8aV/Vr/i0N1KdFNWe6h9puazYMrJCspP6RXV+8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Mm/1ffd9W4wdtpYHvLgSMmQm4ALvJjnw+8NQzt7rLVaqiqcQ7W3vVRa9rMw1ime2h
	 oG0NXNmrCc6Z/ll00G+FYrCbsw57bSSYmJy6FRtjUZjRqvLpEw7U6Vmb4nnyrqHvH3
	 g/OjKL5LI8F8TValE0xD5t1vgL9zw0gynFXFDU05qREQ/65PZog2rnqH6jfhjFwJBW
	 tOlU7vuuKz2CXVCuEpOB6j8STdz4XULu83AEOP+fBsaSZXZlrMTa0QGW8rQ83LKVST
	 5vvEe0U1C3P05Xw+Ee59f0JSt1oKuyZo1+6Dsz+J69lxljXUnmjCZ8PZqtm4zw2+li
	 yM9MrZwxAutVw==
Message-ID: <28f9910579c9365d3f774c6892fb6b189b53f2a6.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 5/5] selftests: mptcp: connect: print pcap
 suffix
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 11:31:41 +0800
In-Reply-To: <79233605-a9e5-4406-9310-bb34063bafee@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-5-dfb3b6b4a877@kernel.org>
	 <5ee562f1700818c635d79828b057a94943527e80.camel@kernel.org>
	 <79233605-a9e5-4406-9310-bb34063bafee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-09-06 at 15:58 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/09/2025 01:39, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for this v2.
> > 
> > On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> > > To be able to find which capture files have been produced after
> > > several
> > > runs.
> > > 
> > > This suffix was not printed anywhere before.
> > > 
> > > While at it, always use the same prefix by taking info from ns1,
> > > instead
> > > of "$connector_ns", which is sometimes ns1, sometimes ns2 in the
> > > subtests.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++++-
> > 
> > Just wondering, is it necessary to synchronize this modification to
> > mptcp_join.sh to maintain consistency?
> 
> I don't think that's needed: there is already a similar message in
> mptcp_join.sh:
> 
>   Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile

Thank you for your explanation.

-Geliang

> 
> Cheers,
> Matt
