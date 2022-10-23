Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F47B
	for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 13:47:03 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id f23so6389423plr.6
        for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nHa8A+7PeIMg7RKdNLlRzsKGG0uAkGmk1JSJv06f7g=;
        b=f2Cppc+QfZk1KXVH6JcNRhs8g7DPxaW5ORqSgC5zYxTOJHX4Znuc/dXjM3N/q6m89d
         +waRzpUa3GYJ7QiIORnDN1J9gVB9Wyqd+F8iwhrsMrD49QrXT9JPTtqzNHUrHJKxgxAE
         1rzC5bcP8RTof1JSPL/cmRJlwYu3SfBGUeQ1YHbbwRZzRyUxUuOwhpckW9eKAoHAIvdX
         D+2N5eg78YTFFRWxrg+5O9RLcTYC5pXXlhVrMvYY9RxQ7rHdg0rifkQn85dPqe8Q+wya
         05lOONZSOoHJLN0FPL0XG/ja/EL2aF4P+Slx3vbLEAezGK4GczXjOgZ86AxFi1CVeti2
         naFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nHa8A+7PeIMg7RKdNLlRzsKGG0uAkGmk1JSJv06f7g=;
        b=DuGpP0hTFCv17o5+LqlnOcoF98HTLTWN3zL7T6PEk/vemEW5gBGqKpCCS6ky+rLZcT
         7o5DEjbd7e8MA4uD39JY6ya5cH3nLRRRxvSgzMjA5ZhpP1+ucW3jJ2HDkkNXwFXysxN1
         FYjQG2/8uuD/6ds7q739YJ5qGYWlxwPXrcAG4JJqkZwYuJQl0dLdGIzGlX6I3BFGjE5j
         HJiQTpEp4ZHDrUrPuslfwkOt/ljCTQqxqwT1xsTC8x3TfGUJrRqxGgfloEQ0T9K7CAgk
         zby9G/kMlwvKcyXUVMSOuSFk4amuYkrWGWFrb8l2S9ECkhTmaN5bVP3rET+GFN3hSURP
         WK5A==
X-Gm-Message-State: ACrzQf0SYRWi8HUyyCcx0CGEpxXkCPmtV/XzfW/IndbP0AtuWGuwtUCm
	2CwgwDwq6hjTCC9POvwQ+v0=
X-Google-Smtp-Source: AMsMyM6NkjM2G8o7YZ+RxKeQn131uK3LWFYzUa0kiOACmGutmZsEEiSpVlcjBePs8fqT48DOK1KZRg==
X-Received: by 2002:a17:90b:4a8f:b0:20d:2f93:3bb with SMTP id lp15-20020a17090b4a8f00b0020d2f9303bbmr68543882pjb.149.1666532823495;
        Sun, 23 Oct 2022 06:47:03 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709028d9000b0016d5b7fb02esm17976494plo.60.2022.10.23.06.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:47:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 3065A1005FC; Sun, 23 Oct 2022 20:47:00 +0700 (WIB)
Date: Sun, 23 Oct 2022 20:47:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: wangjianli <wangjianli@cdjrlc.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mptcp: fix repeated words in comments
Message-ID: <Y1VF1DBYePbkTk8x@debian.me>
References: <20221022070527.55960-1-wangjianli@cdjrlc.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9jz/0j3xO1O4oqZ"
Content-Disposition: inline
In-Reply-To: <20221022070527.55960-1-wangjianli@cdjrlc.com>


--M9jz/0j3xO1O4oqZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 22, 2022 at 03:05:27PM +0800, wangjianli wrote:
> Delete the redundant word 'the'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  net/mptcp/token.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index f52ee7b26aed..b817c2564300 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -287,7 +287,7 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
>   * This function returns the first mptcp connection structure found insi=
de the
>   * token container starting from the specified position, or NULL.
>   *
> - * On successful iteration, the iterator is move to the next position an=
d the
> + * On successful iteration, the iterator is move to the next position and
>   * the acquires a reference to the returned socket.
>   */
>  struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_=
slot,

NAK!

Instead, slightly reword the comment above as "On successful iteration,
the iterator moves to the next position and acquires a reference to the
returned socket.".

Also, you and other @cdjrlc.com developers ignore reviews that request
changes to your patches. If you want to participate in kernel
development community, please don't just sending random patches without
any sort of reply.

I have pointed out this behavior either as part of my review or as reply
to reviews from other developers. I may write this as final warning before
I just say NAK without further ado to your future patches.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--M9jz/0j3xO1O4oqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1VF0AAKCRD2uYlJVVFO
o25EAQDIoaFBeuz0b5mrP55Nk6SpOrkxQQ0pTeEwTsUbrqbC2wD/UsccZMALgll3
5yvwmQtwwSeG2n05VcGxoklMaPFGDwQ=
=mQXI
-----END PGP SIGNATURE-----

--M9jz/0j3xO1O4oqZ--
