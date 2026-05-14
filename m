Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB133FADF4
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767340; cv=none; b=ZYbWvYoC+KddZSaRlyvrLatFpqD4zSf5WZE4x/urawIRo8mgRGpGE+vAnRpteC6MtvBtrYDIomXlY16c0Iq4LkcKCD6c1T3OQ2gFIiRc5rqjSMJxLv9jVKJrSkN/NmsgJTC8FS6mLtG2p5TPRV8K0Z4FQlMlyMWIqpZ42FbKRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767340; c=relaxed/simple;
	bh=8GR6utP/FQdQri1J1OxrSWnqsvNsCQONTC3v/hUqMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsaajNtW4iprPuPppggYk+nPNP8/c5hM8Eu3OnZo2EmfBVyBksZg5TvU7mUqhYWZOaj1JKjzjj3PFC+8vbqV8kZ8+U4EFsCixWgzwlscLrjakzl3+PcZh9gdIzyRwfZWo9e19W3Lal+rJtpeQRYWbaOG43mNLYJAQMctZHGVH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7hItBzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7hItBzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815FAC2BCB3;
	Thu, 14 May 2026 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767340;
	bh=8GR6utP/FQdQri1J1OxrSWnqsvNsCQONTC3v/hUqMtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7hItBzXt8/i3EnJZO08aNbxzpDhjKzebRKPH/82pFG/Od1HSnywDZgU1Sz+/fRIU
	 jSWEF1sjNTQEhdKp8MKJpczMGLegaeS/iKwhhTKve0Fihk++EvguWHnaUG1OX1Vouk
	 9YqfnagJ8p0qeE+H4fhSaEvp+JJlgLztjhwztU3smMqgDA+1Kkiwzh4SyNWGGzSHfY
	 HNWH/QfFhtDd/cWM+nYJEkCEwreYfqLUdfSdI7hyVvoXesWyn9uSLva1+oM8a/Fx8a
	 1dDzJfKgMG0Uz0xi0XYRl8stdZ932+vC6Agl60GUlFkcrAvPB29k9McbnyklJNcNSu
	 ktEA71HNwhyDw==
Date: Thu, 14 May 2026 07:02:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: pm: fix extra_subflows
 underflow for userspace PM
Message-ID: <20260514070218.1534d72b@kernel.org>
In-Reply-To: <20260514132925.410184-1-cuitao@kylinos.cn>
References: <20260514132925.410184-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 21:29:23 +0800 Tao Cui wrote:
> To: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Please don't CC maintainers without CCing the mailing list associated
with their area. If you're CCing core networking maintainers you should
also CC netdev@
