Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667730FC39;
	Mon, 22 Jun 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144062; cv=none; b=eGlePelin1vaAWVph256QVmWwxQSdiDBn8VS0BNcjPKkcyZQRW+TfOWEyEws6KGpZiRj8+ywe2w3E9uGnKzkZNJcEkmybTPPzP6FvJwnQECMMPLJmxamm7Fr+i23V7Nwuwiy3rQB/uXYBKEshlUVgaCxaSwRDOxHwgaJUuSRdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144062; c=relaxed/simple;
	bh=uWrN9N8tLkl5jeJNrH98xFTV+fIzbe5ovyczRTpj/bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EitOkI6tWMUYKAxf9t8RlJWSYkqxH0puuoxBQTNPoczzCJaZ4hUjJW+94IUI0+0x6QfbmpYAWUZEGUk4bvzrDk6CV92IB8jlG3WwbZ2sOHCbzzXSt41GWHHF+Lcw/wJKeliMcxqa/lLCwi0aI6EKVoaSh/vswebItF2U94bXhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUCYAo1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUCYAo1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C561F000E9;
	Mon, 22 Jun 2026 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782144061;
	bh=uWrN9N8tLkl5jeJNrH98xFTV+fIzbe5ovyczRTpj/bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CUCYAo1LFxfge7jZFLyQOPKo6REe5AjDLNc2cU3Y/grBFxpbLVX8lIRYlb64V/8PR
	 AjWv34uaq2AUiOh5QEIu88iNfSXuAq0j4wfzjTIxjwOvzADvFGx2c+uHkWEASeVJfi
	 pCQ/iEuk13mVt8JjjIowFNn2AYbaBWpHWUqFF3n1XsvkTRYPELJ7R2VIOI3Of6hMn+
	 1/GE1XNjpOf9UF785xD54kxObPgjPbwHuwcPYMlLYS9vgNEhbYJ146uBZIugukKkmF
	 hSSnSBoUd9pti4FDBySf7Ki0tQ6pzASJPAQ74UXmAPdqBGX3MHnLyd4nJnyTNEo1J2
	 6wmgdhGkgpEXg==
Date: Mon, 22 Jun 2026 09:00:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Hannes Reinecke <hare@suse.de>,
 Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>, Zqiang
 <qiang.zhang@linux.dev>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <20260622090059.5d1813dd@kernel.org>
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:
> Subject: [RFC net-next 00/17] MPTCP KTLS support

Please no. We have a ton of unfixed bugs and may have to revert some of
the features we dropped back in. I'd prefer to avoid large new bug
surfaces until we reach an LTS release.
