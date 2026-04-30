Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB41632DD
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559349; cv=none; b=rY7vjqBcKhiDUuYy2aQwDqgDFYZeKW5YHoO6St+r4tV61hGYNx7igJhNCJ0km9Rddp8IFXmBm4WYONaoqwIVZTdqQdHO3a0rrPpdN04m3iwNmzKCs5GkxYei4mm52WuGoaM8PhkR4lXxRbglsg6mm1CkoeNVi38rIWfyMm2uCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559349; c=relaxed/simple;
	bh=AJteu4scergaAIicJ3N0kwygg9gaz7E32ObURKLfaVs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sJVklAypK78JESurNKacMN7hUjHJLuPgMxKZSwkpalN8Bc4CuuuDMkLEr3OWd+q7cbjicfZGB63/FUFwAY0kkQg4Pdr5Uk26AjF33NHTENrl1eNbNaPLP+WjrPawKC+H4UmQMja1BQYnTThxneBb6b/UlrsGeSstUzhchVTfB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpE6zmYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpE6zmYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0003FC2BCB3;
	Thu, 30 Apr 2026 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777559349;
	bh=AJteu4scergaAIicJ3N0kwygg9gaz7E32ObURKLfaVs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=QpE6zmYxe++KeVNeY7F9pCthvCFgP3hr+naRtelwIX7BHFnYZNcr0gtajnm2Z0/Mj
	 W1evy7aIbXgzk7hPtMbGgEFZZwnGUafEfq0Ynay711ucs3S2rFCpdytRk+svkuuQEv
	 nOJYWYQP8Cyzlq7whUxoXkFuwhn/0uwhv0fm7echJoWmO2zKGewtOSBWMkXpLWMwNz
	 KPXYwBLACzAylr9Ay+ogO/BrGmLGbrvaLIJSkQV220L1zMIngx8gfKrL6Ni0zu3Zkc
	 HnLsG+FBMm9x47emHAQW4H9WetiCAAbGaFbWI6YDH3+CpHM0sMJEWORDVFRnON4JoB
	 4lV1mxpv5UzLA==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net] mptcp: fix rx timestamp corruption on
 fastopen
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
References: <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
Date: Thu, 30 Apr 2026 16:29:00 +0200
Message-Id: <177755934006.1566930.7793643957734579157.b4-review@b4>
X-Mailer: b4 0.16-dev-76c3c
X-Developer-Signature: v=1; a=openpgp-sha256; l=238; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AJteu4scergaAIicJ3N0kwygg9gaz7E32ObURKLfaVs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/pxvHCu66sG3BqsAIh2/T+sOSFn5YdOVvwUrFwtWdD
 6cFXlnX2FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAnCTVRj+J+eanWz6wxO8ZWGU
 xH696AXnXY1dZt1eMm/xDDv1OSn1wgx/5ZdFt/zdzh+uc3OF1DZnlWvCm+490pw+j0Wn9+SS+88
 YOAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Wed, 29 Apr 2026 13:06:02 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> mptcp: fix rx timestamp corruption on fastopen

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
