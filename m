Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB338A29
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989539; cv=none; b=nf1bQ5H6qJRkVqsqsvlQqZuEw+XvrW0UOFndegIMsFNZBIE8Hq77xgQutbZvjdwAjDOJQX4QU/7Hzqxk0V5DOHIzUbBRV+hvGkizhwgKvIcuVJA9AK0YWGQWYuOX0fSDvdf2tU+Wlzn9esYLi2iGp2ebE+9PKVviN5955uzPUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989539; c=relaxed/simple;
	bh=0qYWDYplg4ufycWoAkw6wlTyMby4anLZUS9sqSQiAl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTxfPDq02NKOw3xqHMcUkvBQTezmH5xJ78EkTuEhU2NB6xxlhVuffI2TG+MJahXTlVcqHenWtjp/N/fMdN78mOP+ITEr6dmaKvUgPx1KfpWWGYUnlAlusvOMjfKTwPJ001JS8+NiNJ6daJgZnyTtMHTl6b2ord/yWbuoQdqa1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fv+pKPrW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fv+pKPrW"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3322f5413easo10305191fa.2
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753989536; x=1754594336; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUihJRmUIuhIgLO8HEMOgsiuYtoOxK4DrDG7wZt5Azo=;
        b=fv+pKPrWlI1EUrBmdeuNnJthPRlGC4pCtHbM2dtdMjciSIfEXfqZPf4IT+B7vpkqZy
         ZJUMJWta/mw6niJJVlR+iEZA2BSUX1R2cO6NutaBt1EkRGiF27SkHdOPTMtRN2WFw8fW
         y/ZSwWcumHi4YbLtp6EP9ucDIQZAUurfWP2Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753989536; x=1754594336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUihJRmUIuhIgLO8HEMOgsiuYtoOxK4DrDG7wZt5Azo=;
        b=K3scGIN/Trap9NWcOK+v6tPoX3ySSu7UJZh3lLCWvKDPiTgCGc3O2s3tdQci2LRIxn
         BFr+zRxj1GUTCezgCJ7leedKHBGPfY4L8b1CyeH/Y3EdMTsDL7UBGG9tti/F1De4yHuc
         DrpIKhSQN8af5R9EQveUg+u1GoNN5CF848dSRbFV7a29nnk5EPwoyKUCQYhumjSWteCr
         1uy2K7qLc9vrtbRjdhmW8coS6rHs5IjHSIPhvvzB6QpVL4B4p5AhEM7prcrQWkiToB7o
         3j32snKdGC2uZcg0AFHbhpUC/izAzNPswvU0skC4HeSRB9+/PeJzyJ4WlniexaAM4Ib5
         Zmeg==
X-Gm-Message-State: AOJu0YwOOHXjkXE4nME3RwtI6EwLn58ZU3mUFV/J9KYCpIIWV1f6qtLS
	/YQEs4Nr7adiUI30aU3/Ng5F0uHTl3XnHN36phbfkaKaWEEI+1cTPt9odYmBwSxkyqarYxYI6d9
	a7ka5+g37xhB9Km21p53vBsMkSqJUONx2AM9jG4bvfpfHOLU+fdsSlP0=
X-Gm-Gg: ASbGncv61CBRuVwX4j+7Viq8I/S7JNHq/6gXM0Tt8EyD7gFVvxJc2cu/PzDmAKup8O2
	C+JQ+AL27rFzIPS5BAgp3jyJR89wVoDOfI6GSROLUTO7QnGrJogClFxNZ9tdsnMaef/UzOnOsTB
	J+RCKjAjSHbJ2HuJibVhY+abv8lWx/u6sbIFFGOTGpJMU31qh81LEoMxknhnzHfoaC99z2ASynM
	lUSdw==
X-Google-Smtp-Source: AGHT+IFK83NOBgFPrdZhmLELYMF0ZqYGy7e7KLmjeNR7ZKfMSS2IsBuv3pHMUIirepu7sCtqMqUhBf/RX0zGEzfRRyU=
X-Received: by 2002:a05:651c:2155:b0:32a:6aa0:217b with SMTP id
 38308e7fff4ca-33224ba41dbmr19700581fa.25.1753989535791; Thu, 31 Jul 2025
 12:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1753946671.git.tanggeliang@kylinos.cn> <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
In-Reply-To: <291bace9364966f432580ba13121bd59677f5d3e.1753946671.git.tanggeliang@kylinos.cn>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 31 Jul 2025 12:18:44 -0700
X-Gm-Features: Ac12FXysw4rrAiOHNfsQYiLuqpTAEflhAT7VULsS5tb5msCOT9L3Z2l-nB4k01Y
Message-ID: <CADg4-L8S1bqK6f6YUWuoEJOziYL-Q0DZY5p2DFStKA4mFi02mg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: setsockopt support for TCP_MD5SIG
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:28=E2=80=AFAM Geliang Tang <geliang@kernel.org> =
wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
> The implementation:
> - Allows setting these options (getsockopt remains unsupported)
> - Applies them only to the first subflow
> - Forces fallback to TCP (since MD5 isn't compatible with MPTCP)
>
> Setting these options triggers fallback to TCP to maintain MD5
> compatibility.
>
> Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.

Just wondering : What does the above line mean ? "unsupported for TCP too" =
?


Christoph

>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index b264185b810d..3ffdeca694be 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -13,6 +13,7 @@
>  #include <net/tcp.h>
>  #include <net/mptcp.h>
>  #include "protocol.h"
> +#include "mib.h"
>
>  #define MIN_INFO_OPTLEN_SIZE           16
>  #define MIN_FULL_INFO_OPTLEN_SIZE      40
> @@ -567,11 +568,12 @@ static bool mptcp_supported_sockopt(int level, int =
optname)
>                 case TCP_FASTOPEN_CONNECT:
>                 case TCP_FASTOPEN_KEY:
>                 case TCP_FASTOPEN_NO_COOKIE:
> +               /* MD5 will force a fallback to TCP: OK to set while not =
connected */
> +               case TCP_MD5SIG:
> +               case TCP_MD5SIG_EXT:
>                         return true;
>                 }
>
> -               /* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is n=
ot compatible with MPTCP */
> -
>                 /* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAI=
R_OPTIONS,
>                  * TCP_REPAIR_WINDOW are not supported, better avoid this=
 mess
>                  */
> @@ -830,6 +832,12 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_soc=
k *msk, int optname,
>                 /* See tcp.c: TCP_DEFER_ACCEPT does not fail */
>                 mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, opt=
val, optlen);
>                 return 0;
> +#ifdef CONFIG_TCP_MD5SIG
> +       case TCP_MD5SIG:
> +       case TCP_MD5SIG_EXT:
> +               __mptcp_try_fallback(msk, MPTCP_MIB_MD5SIGFALLBACK);
> +               fallthrough;
> +#endif
>         case TCP_FASTOPEN:
>         case TCP_FASTOPEN_CONNECT:
>         case TCP_FASTOPEN_KEY:
> --
> 2.48.1
>
>
