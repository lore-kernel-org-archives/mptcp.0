Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2D4687
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203493; cv=none; b=FnWlaBQGrlux26nql1+n1umuWDTlMjn7ejaB5WIGDnRxxR1osFdn+COw0RPCoyPUIaBQ+YFAvaRDyGpFWlD96Y/fh1XpYF168sp6o08G+TxbCiVtX6YHWzL9HN4Iq39YAojDn1nC6b4F63/2G6x0aVdBVN5UmFj7VBfUaOUjI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203493; c=relaxed/simple;
	bh=jdoJYz+ectKIm1R2S/3WTquMQ+5rTDzd7ednx+DAJlc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=llUY+3rSqF2tCefTaWnzi9X6xDCBki2uK/wZwDlYTQmVunJag2K6V4/jh9SgvrhE5zgPTS2ruTleA2iI/YzksEe/busTVkX48uKHa/vdHBqICLXt/jQRD623bHcXbBOygyz8nGz2gK0mrPVsemdWZnVLMQA6y6w2UKTSAcCdJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlhTnw3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlhTnw3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A75FC4AF0E;
	Wed, 21 Aug 2024 01:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724203492;
	bh=jdoJYz+ectKIm1R2S/3WTquMQ+5rTDzd7ednx+DAJlc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NlhTnw3qIUhsjoX4V3/E8ZZxlmXXrGZyslwWSHLRr9VXa3zJMJuKD7JYvE3Z8NxCJ
	 CRMp4E0qxXI1hhegE+5og9RklgDNQ4MOsqlNO5RIEUd2J5F95TO+RwkqXgsjRj5u3p
	 wPP65o+mReQK7bZI/9LF8nrRo+jqCHIYu0QEWCvLxC9sdDXk2pVV7D1cdeT91Fsixt
	 8gCNXpTXNQCdlqSqtTLgzm8HoE9WZpRsL++c3tbqLPd6ihzNynKH5skS4lWFIryp3v
	 GM+8qbc2S+QKF8FQ5gO7BJf3Ke6i6VJz6xYJoccgNRJH3sySB+mh7Jpv4GybH38b4a
	 +l/pBBt9kpCww==
Date: Tue, 20 Aug 2024 18:24:51 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: sched: check both backup in retrans
In-Reply-To: <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
Message-ID: <90a11c1b-2d72-6b29-1139-3295f43269d2@kernel.org>
References: <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 13 Aug 2024, Matthieu Baerts (NGI0) wrote:

> The 'mptcp_subflow_context' structure has two items related to the
> backup flags:
>
> - 'backup': the subflow has been marked as backup by the other peer
>
> - 'request_bkup': the backup flag has been set by the host
>
> Looking only at the 'backup' flag can make sense in some cases, but it
> is not the behaviour of the default packet scheduler when selecting
> paths.
>
> As explained in the commit b6a66e521a20 ("mptcp: sched: check both
> directions for backup"), the packet scheduler should look at both flags,
> because that was the behaviour from the beginning: the 'backup' flag was
> set by accident instead of the 'request_bkup' one. Now that the latter
> has been fixed, get_retrans() needs to be adapted as well.
>
> Fixes: 3b1d6210a957 ("mptcp: implement and use MPTCP-level retransmission")

I think this should have:

Fixes: b6a66e521a20 ("mptcp: sched: check both directions for backup")

and a Cc: stable ?


Otherwise LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 13777c35496c..ad60d04f4981 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2326,7 +2326,7 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
> 			continue;
> 		}
>
> -		if (subflow->backup) {
> +		if (subflow->backup || subflow->request_bkup) {
> 			if (!backup)
> 				backup = ssk;
> 			continue;
>
> ---
> base-commit: 971367a56ebfd1fd70608813898e48681281da99
> change-id: 20240813-mptcp-sched-retrans-bkp-291785163b52
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
