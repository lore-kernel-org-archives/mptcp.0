Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29204351C2D
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041158; cv=none; b=q5bjlEyM73RuxliKSVMrUWiwc3L8kZYR1xKF1QHnWEQBX83Dgj4eMbe7SeCqCDqp4UO126kj4cz/BPBTm3GZv/xwWXGZ+EJgpxvRpUqG2fHkSBrQihlEY4sEzGKuFW4V7awg9cwlKzGafH+GhOEftvVjV8Lyb8BqhMJSskqPTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041158; c=relaxed/simple;
	bh=UTzkI7yKc94RHVZKsL4sIUm+ZbGrcONisOCs02j4pFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8BIjLqGqvzp34WPwnObnrY30eXEJ1jA0YRNcgBJXv2ckG8Gm4t0zlHGN4IQy4QYGVV3YcbWvTk3zvVFdJhbba+IIhpFeNOjsQrY9wHyGq+jzBi05SshCcIx25WN1Kls9zqa+A3zTfeaCuGD6oqlH6cXjUg/8/X81lSCMX2ILDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfzBoscR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfzBoscR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96DC1F00893;
	Fri, 29 May 2026 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780041156;
	bh=upM+bf213UusphCIBxXswZDOlM1snqLe5a6Sfl9B8p4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WfzBoscRkSD832g94NgQh83sSXiwaNATwhrwiC6qnD7aNrFr+BY7dG1VT/ffLL/5c
	 M0eHj0iBheeoUIKMnrGpxe9DQ8T5Uz7omzJ9Ov9205MKEnIzMQbP3CtTii5QPnk3pR
	 46py07OpuPBD19izu4w/vNEb0IN/T/mhN8wjWSLm/f4oSuGzZQC6fQDrQbgZcEEqWT
	 Xm+S2+mYH0LCzCQ6LKgXp3QKBsYhD2/pojtYc89/VJsK9ts3hExMHZhZJFlDSPdsCl
	 TbGOdRshB3eRbtxqHspcE6heBCtcmr5XBGwBw0GW1Akat8BVoYwKKsyd2sE+FXiVzu
	 zRHmTubWcf7qQ==
Message-ID: <8c15b6562bce358644b589ec4bb7618ff7486e2a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: add TCP ULP module alias
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 29 May 2026 15:52:33 +0800
In-Reply-To: <c7f74bd00fd5073d39fae2818aaa12da102a3ad4.1780039666.git.tanggeliang@kylinos.cn>
References: 
	<c7f74bd00fd5073d39fae2818aaa12da102a3ad4.1780039666.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2026-05-29 at 15:28 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add MODULE_ALIAS_TCP_ULP("mptcp") to allow automatic loading of MPTCP
> module when the "mptcp" ULP is requested via setsockopt(TCP_ULP,
> "mptcp").
> This ensures the module is loaded on demand without requiring manual
> modprobe.

Oops! "mptcp" cannot be compiled as a standalone module. Ignore this
noise.

-Geliang

> 
> Also add missing MODULE_LICENSE and MODULE_DESCRIPTION.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/subflow.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d562e149606f..81b562ba81c0 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -2213,3 +2213,7 @@ void __init mptcp_subflow_v6_init(void)
>  #endif
>  }
>  #endif
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MPTCP subflow");
> +MODULE_ALIAS_TCP_ULP("mptcp");
