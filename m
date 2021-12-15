Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6E173
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639563813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL+jO1niNqNzcJwxYMIURGbSqdHqGQ6HenODqC3EVvs=;
	b=hbHF7+LzB5Yupp2Z1DCfORCD1mfsQqwtMZWvE1aebzkYf5U7XIC2nqf5mgfVCQBXw/IyzW
	21YYbG2QXcVQijgdiwlLyJrsZlqx8rngTOrL8be239/qIWXJrSuO7DfGVYt3ZaHFiA4GKg
	979Sw6ZdhaqO9arTa68vuoUbX5pnGGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-QZaDNbMVNRWqaWSNAjn4Sg-1; Wed, 15 Dec 2021 05:23:31 -0500
X-MC-Unique: QZaDNbMVNRWqaWSNAjn4Sg-1
Received: by mail-wm1-f72.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so8804578wmb.4
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 02:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OL+jO1niNqNzcJwxYMIURGbSqdHqGQ6HenODqC3EVvs=;
        b=ftvOPTl9WbpiZkAG1WyWLGqE4hCZOvgrsCJwrESyR3b/XV68CXh9h/zLZzD++XpGsA
         Zo3zQlVE1qjq2k2zt1eGqFJh4xQQLPmCupXuvQbd5QobpGASTrSvJqigOGo5Yf0d1ddE
         sTfTzZoHJxqjSlqJyigZjsvAFsKY1vbomCdCc5DBD7hlG9vH7g0I6e7l3gYgw8zD/h8q
         oMXtmA2WaMqszOjcQeAVK2STeCpcpvDbm7juYMY2ru4GEYPNQiDRL7/Xl6BGqUy1y/PR
         RdeU+9Gf7WNj/lEKwFu4SB9e2dZVhhyCr410Zo1A3xOuOm8BMxCjrqXSoNXWKKeiJLMs
         /ihQ==
X-Gm-Message-State: AOAM5324TNKGD92ixghBl9Psyb1squ8bd86GFT8Ihnims38g1gebmh59
	ESt75RyAeA7Og02pcW1E7iMMtAqidEY9m3w98sjBH+I0H/XAAQ8d5hlsmXCkvOh0rDkm4DbvvwW
	AHcFmJhyUThTLzzs=
X-Received: by 2002:a1c:7714:: with SMTP id t20mr3920380wmi.139.1639563810258;
        Wed, 15 Dec 2021 02:23:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCPG7f0LCabf3giybQUUq8GZN+jrq80o/bA4aD7g/gzbp4YPdo7ORBCOKXJWjC6zKZeFgamw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr3920363wmi.139.1639563809969;
        Wed, 15 Dec 2021 02:23:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id m9sm1440660wmq.1.2021.12.15.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 02:23:29 -0800 (PST)
Message-ID: <767e837adad000e70c0f00e420b22d87d564fe32.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 15 Dec 2021 11:23:28 +0100
In-Reply-To: <f86282ac-0bb4-7190-75d1-5d975016e591@tessares.net>
References: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
	 <f86282ac-0bb4-7190-75d1-5d975016e591@tessares.net>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Wed, 2021-12-15 at 10:11 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 14/12/2021 12:51, Paolo Abeni wrote:
> > MPTCP join self-tests are a bit fragile as they reply on
> > delays instead of events to catch-up with the expected
> > sockets states.
> > 
> > Replace the delay with state checking where possible and
> > reduce the number of sleeps in the most complex scenarios.
> > 
> > This will both reduce the tests run-time and will improve
> > stability.
> 
> Again, thank you for looking at that!
> 
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - fix ipv6 addr handling
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++-----
> >  1 file changed, 49 insertions(+), 16 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 8f49bbd4a201..7014391d750e 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -238,6 +238,42 @@ is_v6()
> >  	[ -z "${1##*:*}" ]
> >  }
> >  
> > +# $1: ns, $2: port
> > +wait_local_port_listen()
> > +{
> > +	local listener_ns="${1}"
> > +	local port="${2}"
> > +
> > +	local port_hex i
> > +
> > +	port_hex="$(printf "%04X" "${port}")"
> > +	for i in $(seq 10); do
> 
> I think it is safe to increase the number of iterations. Most of the
> time, we will never reach the maximum.
> 
> > +		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
> > +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
> > +			break
> > +		sleep 0.1
> > +	done
> 
> Probably here, we should exit with an error, no?

No, it's better to let the caller fail, so we get better/more
consistent error reporting.

This code is copied verbatim from mptcp_connect.sh, I think we don't
want to introduce differences.

> 
> > +}
> > +
> > +# $1: ns, $2: endpoint id
> > +wait_address_deleted()
> > +{
> > +	local ns="${1}"
> > +	local addr="${2}"
> > +	local cnt
> 
> May you declare "i" as local too please?

wait_address_deleted() is bugged and the source of the reported
failures. I'm rewriting it.

Thanks!

Paolo

