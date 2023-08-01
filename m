Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBB20FA
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 07:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D465FC433C7;
	Tue,  1 Aug 2023 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690875722;
	bh=jRSmWh+NhrYAQduCkQ8Q34Std4WJOLn1l6HSknsTOpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eafMNsH/wC11QVsETZ9Gj3AdWNRaEPp8jrjCp2AUB3iaxnlaMiCbIezpMPdCk4f3+
	 N3BIWGIQfZ3dqUWrj0NRbuvGTM66a5jtGqtomhfhhKOOYAYT5a0Tx/KTj23pT4VnZK
	 wVV7i5jN1gyOOaCcj0XnppkqKWjOCgRTOozzrYsU=
Date: Tue, 1 Aug 2023 09:41:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y] selftests: mptcp: depend on SYN_COOKIES
Message-ID: <2023080153-botch-slapping-ebf5@gregkh>
References: <2023072148-curry-reboot-ef1c@gregkh>
 <20230726165547.1843478-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726165547.1843478-1-matthieu.baerts@tessares.net>

On Wed, Jul 26, 2023 at 06:55:47PM +0200, Matthieu Baerts wrote:
> commit 6c8880fcaa5c45355179b759c1d11737775e31fc upstream.
> 
> MPTCP selftests are using TCP SYN Cookies for quite a while now, since
> v5.9.
> 
> Some CIs don't have this config option enabled and this is causing
> issues in the tests:
> 
>   # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration   167ms) sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
>   # [ OK ]./mptcp_connect.sh: line 554: [: -eq: unary operator expected
> 
> There is no impact in the results but the test is not doing what it is
> supposed to do.
> 
> Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Backport notes:
>   - We don't have kconfig that have been added later, that's normal.
>   - Only added the new kconfig dep then.
> ---
>  tools/testing/selftests/net/mptcp/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 1a4c11a444d9..8867c40258b5 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -6,3 +6,4 @@ CONFIG_INET_DIAG=m
>  CONFIG_INET_MPTCP_DIAG=m
>  CONFIG_VETH=y
>  CONFIG_NET_SCH_NETEM=m
> +CONFIG_SYN_COOKIES=y
> -- 
> 2.40.1
> 

All now queued up, thanks.

greg k-h
