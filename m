Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62F30FC3D
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455420; cv=none; b=TxPOfDNi+yUn4qSdpYsyRmdGQtt+QtTdqENo0J9EMjQURarV8T+a6PEa73nRHzgUrD2Kuc2MI6a0FLMArBSWOBEzgr4UhaPjqc9FG6bL4f68mc3WSdWVQXZqIU5S5UxL/xBjvBQU6HBOGwFUVe+Y2uJAl9Wfcdus0oP5ktTyRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455420; c=relaxed/simple;
	bh=/JSQXiTfJV3GZJ5dnuNIu3fiZ3VUbv9S8wwtLcqiR4w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuBm/U2CGrci9W7q1sOW1BRIQ8VbaFc+VYVHNDmChRj3IB9m5awDNjxwzZ12VDsNZoNOUkv1Iiz6+Cl+6/FyvzSS8z9C188z29xtGlXHKpi+NFzv8gdBsRv5IOlxhADd+a7fIHfS9Qyi4EbHYnI+4zqFArl0h3Y6/ztD/GaDXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzbFidMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzbFidMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C75C19422;
	Tue, 18 Nov 2025 08:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763455419;
	bh=/JSQXiTfJV3GZJ5dnuNIu3fiZ3VUbv9S8wwtLcqiR4w=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=FzbFidMH+SHGtwM+PU0jNX5M3zIhgDG5c7g2Y4RVUx1h3V3jO5cHT2hsbWI7xV8NQ
	 S77ruDfFzLbdEBPjrqcdnu9y2uvTq4xAmmZ+45ZUwSlKwLO4ZbY14953ywbWpBMpqk
	 r9E0QDC2m5KgrW03qL6NcUWR1kWTlPk28CjVAr3zkZn3Ht4ryXiAbVp/j5EchmYUYU
	 +WfvY0JMLw4msOXIu64MsgUAWEqk8dDFAxuXc95czcaZjIGtRMjyWDM+w6CmSQrJKe
	 NZI0CaGApLVFVHEoOF1Dm8+zA9Quhhe3jRX12MyXwTX7jqR3jj8niRXvtBLwNn3Kkf
	 Lbb9m8vAZn3Jw==
Message-ID: <899b64e9d595ac0a2b256041bf91dba0010fcd9c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: join: longer timeout
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Tue, 18 Nov 2025 16:43:33 +0800
In-Reply-To: <8aeea045-c68d-493a-8f83-4a9187480428@kernel.org>
References: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
	 <8aeea045-c68d-493a-8f83-4a9187480428@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Mon, 2025-11-17 at 12:08 +0100, Matthieu Baerts wrote:
> Hello,
> 
> On 12/11/2025 10:45, Matthieu Baerts (NGI0) wrote:
> > A previous attempt was helping, but not enough as the background
> > connections were still stopped after the timeout. That's what the
> > MPTCP
> > CI recently reported with the "delete and re-add" subtest taking a
> > bit
> > more than one minute in a debug environment.
> > 
> > To play it safe, and because increasing the timeout for the
> > background
> > connections doesn't change anything to the end result (the transfer
> > is
> > not checked in this case), all subtests with a background
> > connection not
> > waiting for it to end now have a longer timeout.
> 
> I hope it is OK if I apply these patches now: they are simple, linked
> to
> recent patches, and we still have quite a few patches in the queue.
> 
> I'm planning to send them with other patches we have in the queue for
> net ideally today.

Sorry for the delay. I just replied my RB tags to them for -net.

Thanks,
-Geliang

> 
> Cheers,
> Matt
