Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77038264A9D
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065837; cv=none; b=PQrDyAZziizdsZs4RD9T+daGQo6guMTfWD2e7ZHN0NVx33S4hVS4lSGs5fxBV0L7JHjL/LWxvf2I1b4DDJ/VteqJrGviJzBZMZ8vBCXNy2cnyYbUt/om/IyhwCob3161DPQTDyf4oVHfCf1kv1Zw72V1j3xOY7UuJ3XQ6KObfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065837; c=relaxed/simple;
	bh=MKujtkBvtKsEmxJNR4+dk0k5ALuSeYJKXftLxqf7XpI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dHTNbQv8wy8mphm6/sjHBPPtatEBEd2oR6eV9m5iw6j/YgjqlPJsBbcRyHDaTzoxJ2xaPPiln6f01OpfezJUhYYdySBg40cLzFenB1e30S0RverAoH04uqs8oAKCk3S4NbDX1Qjmm1O3SkzBcSXOHFk5OlKj07DB1eFW3K5zJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFftpTXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFftpTXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E4C4CEF7;
	Wed,  1 Apr 2026 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775065837;
	bh=MKujtkBvtKsEmxJNR4+dk0k5ALuSeYJKXftLxqf7XpI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=sFftpTXo51aNeOuodp+GFiAh3K/dCrRgVlnJxEHjHo6VX7ZNZ/oJuA+Yebd7HKA+G
	 EXWuSkaPur6AC/fgOsudVDn6hVixN6n9OWGidU0UsYjeT5uG2eJ0UfqKmXjAMJ9KCW
	 NIzkrOoJQVJyze1Aoj8vWYi6cFgu1JRsttYCFU538hAD25qk0aLc2KRMzmjg7FQx1p
	 DngVsz2FD1ZASygJ+5478ma9F3PCZCmOzwQ1gUESpfX3MgnhLXldHqP7BjdIckvmv8
	 36ZhMD0gZ2zO0t+jgCKiJHD+9KqstWvb1wY1iJI1z8lr1jZzVNKBWemo/MCELbqpXo
	 P1mOW6DxS2Pxw==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: preserve MSG_EOR semantics in
 sendmsg path
From: Matthieu Baerts <matttbe@kernel.org>
To: Gang Yan <gang.yan@linux.dev>
Cc: mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
In-Reply-To: <0bed96b3828c0a67950993fc0dd9233c17b94abd.1774947296.git.yangang@kylinos.cn>
References: <cover.1774947296.git.yangang@kylinos.cn>
 <0bed96b3828c0a67950993fc0dd9233c17b94abd.1774947296.git.yangang@kylinos.cn>
Date: Wed, 01 Apr 2026 19:50:24 +0200
Message-Id: <177506582487.2123138.15827856625780021897.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MKujtkBvtKsEmxJNR4+dk0k5ALuSeYJKXftLxqf7XpI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPRr2u7VVycm9Nm3v6Ze2ccG8z7SnW1vO3L1G6oLvko
 ARv3dR/HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOJOc7IsOhH+VUHyaBMiW+Z
 LMGVfvJdzOqnjxwxOGzdryBefyHuOMP/9LrvvVszOefcubKT7aWYluE2v7j2Oh+D/wlqb9LvcGx
 jBwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Tue, 31 Mar 2026 17:08:09 +0800, Gang Yan <gang.yan@linux.dev> wrote:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index afdead91a4d7..db96f2945cbd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -265,7 +265,8 @@ struct mptcp_data_frag {
>  	u16 data_len;
>  	u16 offset;
>  	u8 overhead;
> -	u8 __unused;
> +	u8 eor:1,
> +	   __unused:7;

Here, we could also use the whole u8 than using only one bit which is a
bit more costly to read/write, and we would avoid any KMSAN warnings (if
any).

I can also do this modification when applying the patch if that's OK:

  u8 eor;	/* currently using 1 bit */

WDYT?

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
