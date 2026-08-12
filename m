Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA4353A86
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568099; cv=none; b=b1OmDoL45f+eWhi/3iBOgCzJQVX5XIgkHDtCLBkvU5rvDjZrAJUs5ZdbozheEUKQUfTOBb6BCWrcQbpMpTFUc7VLSLOdO3n8rCVuT8DptwiyOSy4hcfT9fFKAmS6eLO83HxJQEbTIO7My7Lmmbsp4levnqZRpcK1eAg86Yy1+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568099; c=relaxed/simple;
	bh=QkpZPESH8HNhdM4y9Sw07JBV3wmrZqc9nG12HtUQYb4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=orwjgja7Bx+7bGYddEBgcGDBoz8NjYRMURq4LI05oMEVSNV+bKenY2EXwipZvdW/lazkP4uHqyFQPu6Q9cF4sDSfgp5yIqLksd6UqVXNIzuS6WHAMgyZmtaxGB5PJUhRukFGnEojpMaciGG541vlUpeSrSZ90AwFH0BOJTeb0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZcAdfsk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZcAdfsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E016C1F000E9;
	Wed, 12 Aug 2026 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786568096;
	bh=QkpZPESH8HNhdM4y9Sw07JBV3wmrZqc9nG12HtUQYb4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=XZcAdfskB4DzZ6EFJ/S+YDUAy5wnVcqZkFoHGwtCWShcoGfNUgJkYhLzytSpKqkHl
	 sSAOzfwoSEHPLEJ1TYBEQHADINwpfbNIaEXjLNvr5AjSboGuSvvRXfoDSwtzOMxkgz
	 efUQgVlpPmnLsMAO/WHB5UVL8eLXNUEZ1WA4kQIlFq9q7oKXSV4hwIDD47tz/HpDwQ
	 QXbozWOp2h8u0JMBBkM+1jNOqNk3BtPPlDZ5HLbujggXUbDCwqJoTKaMPMS8cmHywX
	 /DWdZV5XDyhE5H+IN7J4HDYb3dQ2xOsRzJeUkbKNU3J5T3jvApZtLBSJxXf1ROl99E
	 /4DhMNNUBCZhA==
Date: Wed, 12 Aug 2026 22:54:52 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Message-ID: <cbdf8539-65c0-4bf2-ab43-bf3481b0971f@kernel.org>
In-Reply-To: <cover.1786553006.git.pabeni@redhat.com>
References: <cover.1786553006.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/4] mptcp: a few fixes
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <cbdf8539-65c0-4bf2-ab43-bf3481b0971f@kernel.org>

Hi Paolo,

Thank you for the fixes!

12 Aug 2026 19:08:30 Paolo Abeni <pabeni@redhat.com>:

> This is mostly a follow-up to the recent OoO queue pruning series.
> Explicitly targeting net as we have already a lot of patches pending for
> net-next, and no need to rush IMHO.

(I hope it was OK for me to send a few small cleanup patches)

> First 2 patches addresses explicit comments from sashiko, 3rd one is a
> somewhat unrelated cleanup I stumbled upon while implementing patch 4.
>
> The last patch fixes another thing implided by sashiko while reviewing
> the mentioned series.

When reading this, it sounds like there should be 5 patches but only 4
have been shared. Just to be sure: is everything there?

Cheers,
Matt
