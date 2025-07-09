Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A43E3B7A8
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046608; cv=none; b=FhJ0tfgByoE8N01H+FVRJvztwM+dFCSTfd+2BuQbw+OZJXU629ziczvB7TJRY5R+EfWOxLk7upsKMfe36m6fpx6xVoNQNI4ZF0Hn2C9rIVCqfOlNQIeVfafXKNUsGX3fNpR9HJyDJejN+qIMSial+AUBSjc/8AwufYSTJP3Bdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046608; c=relaxed/simple;
	bh=SwKJVOQ4BMq4IyV6WSYmOooG0Yc2K7j9rBKtawkPbP8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=abeWBk6KsGKO3qYIlo5c881FGUawh0qlsaZvSRTHWegyzmPy0KiX0wGnZVF0EoIor6gNxEFJnWLZtF1mOq8zUuhgbW6HhL5xlcIwVUXjKqCHZAk9wfUUwMCtQnZLS+yqFEwfKEUJtEjePo43TiObBuF7ldFyY/FsKZPhS8laGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft8Z4TkQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft8Z4TkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66743C4CEF1;
	Wed,  9 Jul 2025 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046608;
	bh=SwKJVOQ4BMq4IyV6WSYmOooG0Yc2K7j9rBKtawkPbP8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ft8Z4TkQcrGerFzs+skcxdSqBnYSC6d+/8SseHzd/9oQ5hpZXlsGUsMWI5sy+7URn
	 XC0hQLFeGHMHuJ/i6Dk09B+cJBsfI9a6Fn/7gS5NJUP1O3fwshKyI20F8EoYq3x5Lm
	 iZiXT1T1tL0jbIa+te+7NrrD7vjRjfDdZzHWT01AbI/L/N5nAZpQfjXP9sMKfxDlM3
	 L6vgVSGfxrO2bWrIVvhkLLlRo/A2czmGeALaS0x2EGPMrM50iNAgtMB+X+I9BS0WwH
	 Mlqm2SM+H63DFGXzW8UlJCejOG0iDq7oEICH9fDSxMZTe2PcKmeP1lLNOHmR71i5MW
	 vG7kok5TxC5sg==
Message-ID: <2a1fae363cad066180b0cb44aa320c9d6fd71aec.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: connect: cover alt modes
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 09 Jul 2025 15:36:36 +0800
In-Reply-To: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
References: 
	<20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
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

On Tue, 2025-07-08 at 19:37 +0200, Matthieu Baerts (NGI0) wrote:
> mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C".
> 
> These modes should be validated, but they are not when the selftests
> are
> executed via the kselftest helpers. To fix that, new test programs
> have
> been added, simply calling mptcp_connect.sh with the right
> parameters.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Matthieu Baerts (NGI0) (2):
>       selftests: mptcp: connect: also cover alt modes
>       selftests: mptcp: connect: also cover checksum
> 
>  tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
>  tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 4 ++++
>  tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 4 ++++
>  tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 4 ++++
>  4 files changed, 14 insertions(+), 1 deletion(-)
> ---
> base-commit: df15676c95d593e64720b86babe913924c3d5649
> change-id: 20250708-selftests-mptcp-connect-modes-5d7aa9e1158d
> 
> Best regards,
