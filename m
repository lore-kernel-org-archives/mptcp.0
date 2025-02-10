Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B025C6E2;
	Mon, 10 Feb 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217010; cv=none; b=cEcuKEvGtVQ7yJfhjTzeGH27rYIjAkwhUX3L6KIc/XMUqowB+bz0VMswgnjFqA9OuDIfYiaARDEvpyrzsX7qBcIJ3RoFpR1dqgVOe+VNIbIV67DO0zctP79SmNkY7F57ESSZB222jhBks7PlPD2wmUc4UXO/kYpkJ8bseGAbSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217010; c=relaxed/simple;
	bh=4JWcVd2vzUIoR1C215Nn23GbTGt8DK06wOcLJd0Keuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP0Y+WUNscCqljVOMaEnGHOOLHxwHmpHvvPiM1J2QoRV5sdNrALhOZvhN7OKNKZTWxXnpODIYeP45EucMZnvciiHTz8AISEM6z83/2isycv9UqTE0isrhhs1s3BQBhYEMJftHHpxIpgNzcwbyfvB0f3Oy2nhHucsTfcT/3KEPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueoMkGmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueoMkGmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33575C4CED1;
	Mon, 10 Feb 2025 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217010;
	bh=4JWcVd2vzUIoR1C215Nn23GbTGt8DK06wOcLJd0Keuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueoMkGmk/63+MBcM2bilWIKFdTzpStUIibAA352fYvUcl0I+yFKoLbTOXbR2j3JLD
	 f6rQmllXekE9I0r7NqZcgNzcO9qxpxap/AGvQTvqAnKGgE0XT32JOeRh0A95xKHKzd
	 bxFWhyb2Vw5Z88q5jmfg9hjHtjAEySLHSrsiuzjf1IuBaAUQZVTVL2ss0dGPEQtr9b
	 IKwxdSc2Xe/JFe6CzFi5uJC62W4Ih1JyWE5TtTAtsLjfQ3iEXo3h651aTKsyOeTtcd
	 UOpEXrr1pgNuzcr7bcFttKnVtO/SfyXIwOPw8YtX9pzIPWlMnEvqh588DtvLZdSXHr
	 RWcNm78H7JGSg==
Date: Mon, 10 Feb 2025 19:50:06 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/15] mptcp: pm: more precise error messages
Message-ID: <20250210195006.GQ554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-3-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-3-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:21PM +0100, Matthieu Baerts (NGI0) wrote:
> Some errors reported by the userspace PM were vague: "this or that is
> invalid".
> 
> It is easier for the userspace to know which part is wrong, instead of
> having to guess that.
> 
> While at it, in mptcp_userspace_pm_set_flags() move the parsing after
> the check linked to the local attribute.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

