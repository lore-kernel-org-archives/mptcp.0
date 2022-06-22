Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203410E8
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655891638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/w3h3rGbkHNy2EhKXLEOk8KM5Faay2hdZ+/PMheFMR4=;
	b=F/bvtv3WyJBthomM7h8ViyMn1x+t7nI/YLRU1N0y7Qr4nSYTiqkX/2Jcxmju4t9emM1wTZ
	fLSDRmGJQCtrgvMJGA/wuLP+tHK63rwV7WWMt6hePREl1Kwis4JV2BiZUrLjc9mwtAyYfX
	p2+QEJdBwzmyYGNyLT8bDhGD4KnmtPA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-n-lhkrB8MDeAnRjm_duNjg-1; Wed, 22 Jun 2022 05:53:57 -0400
X-MC-Unique: n-lhkrB8MDeAnRjm_duNjg-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so3879065wra.15
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 02:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/w3h3rGbkHNy2EhKXLEOk8KM5Faay2hdZ+/PMheFMR4=;
        b=iCqFS46cSKqUtO08Go1tutRvWVsrW77BrG+bY2pI/EC/zLEkA7hAkTrktUkub8qc0M
         RZGFyCRWrPFr0F9oWU0P0OdRzy5g9tB79W//I0wW7jhVzQoMTAxF+2SrAe4Le+3VdopE
         QBQfo1QfmqZY861x2A3u5d6Xe5wIa1VKh2q6mGd6XAdeI96N/BU7oaTQOfYeFUh5uox1
         N7PETJyBV9tMBC53zZzgCkFyMT+9wmoWaeLe4gHp0JqSkxrJmNrwC4a+F65WNiqfhTff
         zets/a30zGTQlCXiNOtXOjgctXwOYlhOl/Kcx8BlxIeh9mGILds91LTYFGYV+tTOsN9z
         OURw==
X-Gm-Message-State: AJIora+CEiEWZ/SDdRXpGBZXsVQZjr9qCsiaffWtgQUY4O9FgslMBmDJ
	cXADt7DwLh4Xx0uelELLcXJ6NwoQ0dNCKRutT6zcVw8N1laf0V/0LGbgNSBLk5K0xGrv62qGIZ/
	CQPR29ClAXvYz6I0=
X-Received: by 2002:a05:6000:18ab:b0:219:ed2e:be94 with SMTP id b11-20020a05600018ab00b00219ed2ebe94mr2442696wri.270.1655891636150;
        Wed, 22 Jun 2022 02:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tjidOTlmJdzU/IX+SG5B9OHfjl0fWOHueSQkdWQo1Q79DaKVe4UKSxJ6SVD829nNpAinhzYg==
X-Received: by 2002:a05:6000:18ab:b0:219:ed2e:be94 with SMTP id b11-20020a05600018ab00b00219ed2ebe94mr2442676wri.270.1655891635838;
        Wed, 22 Jun 2022 02:53:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id cl10-20020a5d5f0a000000b0021b92171d28sm8756811wrb.54.2022.06.22.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:53:55 -0700 (PDT)
Message-ID: <de318850f95461401b64b60a9f4f6bbcac305756.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: Initialize variables to
 quiet gcc 12 warnings
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Wed, 22 Jun 2022 11:53:54 +0200
In-Reply-To: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
References: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-06-21 at 17:18 -0700, Mat Martineau wrote:
> In a few MPTCP selftest tools, gcc 12 complains that the 'sock' variable
> might be used uninitialized. This is a false positive because the only
> code path that could lead to uninitialized access is where getaddrinfo()
> fails, but the local xgetaddrinfo() wrapper exits if such a failure
> occurs.
> 
> Initialize the 'sock' variable anyway to allow the tools to build with
> gcc 12.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
>  tools/testing/selftests/net/mptcp/mptcp_inq.c     | 2 +-
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 8628aa61b763..e2ea6c126c99 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -265,7 +265,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
>  static int sock_listen_mptcp(const char * const listenaddr,
>  			     const char * const port)
>  {
> -	int sock;
> +	int sock = -1;
>  	struct addrinfo hints = {
>  		.ai_protocol = IPPROTO_TCP,
>  		.ai_socktype = SOCK_STREAM,
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
> index 29f75e2a1116..8672d898f8cd 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
> @@ -88,7 +88,7 @@ static void xgetaddrinfo(const char *node, const char *service,
>  static int sock_listen_mptcp(const char * const listenaddr,
>  			     const char * const port)
>  {
> -	int sock;
> +	int sock = -1;
>  	struct addrinfo hints = {
>  		.ai_protocol = IPPROTO_TCP,
>  		.ai_socktype = SOCK_STREAM,
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index ac9a4d9c1764..ae61f39556ca 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -136,7 +136,7 @@ static void xgetaddrinfo(const char *node, const char *service,
>  static int sock_listen_mptcp(const char * const listenaddr,
>  			     const char * const port)
>  {
> -	int sock;
> +	int sock = -1;
>  	struct addrinfo hints = {
>  		.ai_protocol = IPPROTO_TCP,
>  		.ai_socktype = SOCK_STREAM,

LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

