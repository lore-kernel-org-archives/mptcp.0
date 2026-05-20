Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896933A032
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281513; cv=none; b=f59zsWvS0zh9vhgQ/x+/DL/9y6fbiufPFnV0gqMbuqm3NXNJt+zlPKRDihbsSnFk5PWifqGUwV7iJI5rMXMQcPzbhjiZUqN2lAKG7hEnp75t2W0+GShcRLrsmgYObtFipivD0KcB0V49MmQgXnR+iIXuzCHoWKGRK5pTa8cIEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281513; c=relaxed/simple;
	bh=8HsRHOqyCvj1Ycp/gjFyw+JcAbeLAANgyIHBHBfPdIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqLSWsWwJiu8/gPUV77jUZ0J3a2bmTPL5eGzo39RfmC0FYkz6Yfpt9XIkMYJRwMyIJD3xIzBJRUNNbI8l7kGqPUmJL40HuS3aTcYBkI9TcnkOM7iuAP9BNMa/6tIA8JaarIQ6lC+2DzeJSgnV+hV+MDii8bobvFR5yoK5eEEwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kas36HTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kas36HTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FCD1F000E9;
	Wed, 20 May 2026 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281512;
	bh=tQ9czxhuqnLZpU2OmMuXU45mkCEU8y+u6wAkUC8JbTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Kas36HTQxlDcRtiUMLaAp2XCQeMuG+fikQ8m34GB5N8qQaVbkKD5zXWMCczEJuIxn
	 zbKj3E6kUjIYj6MjtF6gklGxcEBEvHKd5hHZL0w7nFFcJm9xSWJ5P/qtQ5B4tL3lUR
	 +LJ/7xW/Xrd2ch3NVNbk86aeJM7w0bWAtDGTcanzoEeH48yW1/QRyxRxE9YsfH6Jt1
	 CoH9Kmtw5Iuc+VomFrDlYpX6eer/gbnhRLAosPK+2kcCz85zo9FC5wTFDXs1VmtSRP
	 MjU0+o/RUOFEIRLNDJoj9BT6CTOzz7jcTVuQgnvV48N76I+Sz3vNF/0v2X79SjKJ6l
	 KodaRg8ohubEQ==
Message-ID: <90151343-08ad-4886-b4fd-ced053e88042@kernel.org>
Date: Wed, 20 May 2026 22:51:48 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: pm: fix extra_subflows underflow
 on userspace PM connect failure
Content-Language: fr
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
References: <20260514132925.410184-1-cuitao@kylinos.cn>
 <20260514132925.410184-2-cuitao@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260514132925.410184-2-cuitao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tao,

(only kept MPTCP ML in Cc)

On 14/05/2026 23:29, Tao Cui wrote:
> __mptcp_subflow_connect() calls mptcp_pm_close_subflow() on failure
> to roll back the pre-increment done by kernel PM's fill_*() helpers.
> The userspace PM does not pre-increment — it only increments after
> __mptcp_subflow_connect() succeeds — so this decrement is spurious.

Good catch!

Could you add a test to validate this case and avoid regressions, please?

e.g.

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5acd12021e6e..38ba10527996 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4100,6 +4100,10 @@ userspace_tests()
                chk_rm_nr 0 1
                chk_mptcp_info subflows 0 subflows 0
                chk_subflows_total 1 1
+               # also check counters with errors at creation time
+               userspace_pm_add_sf $ns2 10.0.12.2 10 2>/dev/null
+               chk_mptcp_info subflows 0 subflows 0
+               chk_subflows_total 1 1
                kill_events_pids
                mptcp_lib_kill_group_wait $tests_pid
        fi

In a separated patch, using the same Fixes tag, like it is done in other
"fix" commits.

> Fix it by gating mptcp_pm_close_subflow() on the PM type.
> 

Please add a Fixes tag, and use "mptcp-net" prefix for fixes.

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  net/mptcp/subflow.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d562e149606f..c45ad67cb650 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1716,7 +1716,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
>  	/* we account subflows before the creation, and this failures will not
>  	 * be caught by sk_state_change()
>  	 */
> -	mptcp_pm_close_subflow(msk);
> +	if (!mptcp_pm_is_userspace(msk))

It feels wrong to call mptcp_pm_is_userspace() from subflow.c: only PM
code should deal with the different PM.

> +		mptcp_pm_close_subflow(msk);

When only looking at this diff, I would suggest moving the userspace
check to this PM helper, but I don't think that's a good idea. Instead,
I think it would be better if the userspace PM keeps the same behaviour
as the kernel PM, and increments the extra_subflows counter before
calling __mptcp_subflow_connect(). Would that work?

>  	return err;
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

