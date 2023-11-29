Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1811D521
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqSg0K5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AFEC433C8;
	Wed, 29 Nov 2023 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701281282;
	bh=3U1nLmkt/9NP5RRiTZbUQ/QSg5lpf9lk2bXY8zfFyPw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MqSg0K5drIDeGq1ASm30ciCvIo9LuNm2jRbBS1jcS9ecq68r32F+cTbo9GqfZM53k
	 47WRggsOUQSOKUWm/WHANctHreku0JrhxwAcrSY+GbRuSUaN0C8xm89akVRIAPKfao
	 dTgmv+GP3oZ3/EzB2TTXaCb4zXhra8CltSWet/zMmOgHDn0Gt5inie4P2b/1cNBg5c
	 NUXJCL4hXDVdm0yXUxkjdGTfkSMVsFVFl3tI3ZA5W6O4KIq0FtjuJKgArC9OdckBcM
	 9RUr5JKB6whSi+JBWlg2j9igQmkyc1mwJwdEv8krA4D3XHh8BfEwfek958hohzCS+1
	 Db2fuDfO5n9Fg==
Date: Wed, 29 Nov 2023 10:08:01 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Maxim Galaganov <max@internet.ru>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 3/3] selftests/net: add MPTCP coverage for
 IP_LOCAL_PORT_RANGE
In-Reply-To: <20231129113403.157953-4-max@internet.ru>
Message-ID: <6de1e914-ddfc-f029-4349-b1a2186834ba@kernel.org>
References: <20231129113403.157953-1-max@internet.ru> <20231129113403.157953-4-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Nov 2023, Maxim Galaganov wrote:

> Since previous commit, MPTCP has support for IP_BIND_ADDRESS_NO_PORT and
> IP_LOCAL_PORT_RANGE sockopts.
>
> Add ip4_mptcp and ip6_mptcp fixture variants to ip_local_port_range
> selftest to provide selftest coverage for these sockopts.
>
> Signed-off-by: Maxim Galaganov <max@internet.ru>

Acked-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/ip_local_port_range.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
> index 75e3fdacdf73..0f217a1cc837 100644
> --- a/tools/testing/selftests/net/ip_local_port_range.c
> +++ b/tools/testing/selftests/net/ip_local_port_range.c
> @@ -146,6 +146,12 @@ FIXTURE_VARIANT_ADD(ip_local_port_range, ip4_stcp) {
> 	.so_protocol	= IPPROTO_SCTP,
> };
>
> +FIXTURE_VARIANT_ADD(ip_local_port_range, ip4_mptcp) {
> +	.so_domain	= AF_INET,
> +	.so_type	= SOCK_STREAM,
> +	.so_protocol	= IPPROTO_MPTCP,
> +};
> +
> FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_tcp) {
> 	.so_domain	= AF_INET6,
> 	.so_type	= SOCK_STREAM,
> @@ -164,6 +170,12 @@ FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_stcp) {
> 	.so_protocol	= IPPROTO_SCTP,
> };
>
> +FIXTURE_VARIANT_ADD(ip_local_port_range, ip6_mptcp) {
> +	.so_domain	= AF_INET6,
> +	.so_type	= SOCK_STREAM,
> +	.so_protocol	= IPPROTO_MPTCP,
> +};
> +
> TEST_F(ip_local_port_range, invalid_option_value)
> {
> 	__u16 val16;
> -- 
> 2.43.0
>
>
>
