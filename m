Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17362AB5A
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689169589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC0wimtaBcHcDuO0kA8vxwCxF55ZadzoG26BhmSHyXs=;
	b=JO5+/qkJBJyd9WPuluYzEboTH4GXfK0MOvkclEcH3mQaYu4y8sD6RPWUgwSENGFs4k46Yd
	MCefWJoCzS6q/oO2NLJ8YoN4fetFW+NOixqHiOqL4pQnfUCdJF2fJCCH/65TGMQ3BsaRpi
	GwfdBlDf9yd+bhx7J8LxJ+lMwUjxePc=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-KJwg5tVPPLCleDh5pcYF5w-1; Wed, 12 Jul 2023 09:46:28 -0400
X-MC-Unique: KJwg5tVPPLCleDh5pcYF5w-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-47ec270d0ffso129390e0c.1
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 06:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169587; x=1691761587;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LC0wimtaBcHcDuO0kA8vxwCxF55ZadzoG26BhmSHyXs=;
        b=KMfZ0RYjb+0ACTSXmON2vkd+XviAfqJ5qTpux2+RGaMvRSjgm+oENG2sTYQkM3r+RB
         TJ6h8DndtwvOoRY7zUi+B/6scELLy6MlLqm86sQhTzCA7Hj+XKw7+4sdt1F9cM39JqaX
         KUrCpCD4J+qp5gmcy+PZGTddy+QUkCtsXGG0Vos8yyPaa8aQE0BTFeSPM8XgX3utIy4m
         oYgN5MkCkKe8Daseh3osoSizx2lhLRykUzNYLYdwCT5Thm52freBnhYps2QO7gEVzEgx
         UUCEDgiq3VLmTwhe8uTQWbHcOkw/hX++8ey6Cskr1fyiU5+WvnD40G9A+vCl/hBDiNIL
         /Htw==
X-Gm-Message-State: ABy/qLaZoRrUcPPhJbv9pMKJpsnx37yBjQhtvErxnUMGL1RN2aE4DUd5
	rXf+HEll+QPfe6U37/3x98tNy/GQCPg7RL0CwxXei2alOGsXaIprjoZDOsrhHoABci/wi3NRZl0
	g/hKhFAicZ29O9yqzmL9Nl24=
X-Received: by 2002:a05:6102:3d12:b0:443:5da9:457e with SMTP id i18-20020a0561023d1200b004435da9457emr6697683vsv.0.1689169587502;
        Wed, 12 Jul 2023 06:46:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHKtmM8q6si2jmB7xc0A4Jf9uSVWjWaTOwy9xJt5g6g82coQfEOqcOiZ8ba0ykX8r0l6LFi9A==
X-Received: by 2002:a05:6102:3d12:b0:443:5da9:457e with SMTP id i18-20020a0561023d1200b004435da9457emr6697678vsv.0.1689169587170;
        Wed, 12 Jul 2023 06:46:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id x26-20020a0ca89a000000b00621268e14efsm2215469qva.55.2023.07.12.06.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:46:26 -0700 (PDT)
Message-ID: <e6d6a299388b5e2324989d1063a80bbdbbd17329.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 0/3] selftests: mptcp: format subtests
 results in TAP (part 2)
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 12 Jul 2023 15:46:24 +0200
In-Reply-To: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
References: <20230712-mptcp-issue-368-selftests-subtests-v2-0-c8b174c18f93@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-07-12 at 13:33 +0200, Matthieu Baerts wrote:
> As discussed at a previous meeting, it might be good to print the test
> name earlier to avoid confusions when there is an issue: sometimes the
> error is printed at the end of the previous test and then the test name
> is printed.
>=20
> While at it, the code has been uniformed and it allows new features,
> e.g. colour support, see patch 2.
>=20
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Changes in v2:
> - Address Paolo's comment in patch 1/2 to print info only if there is any=
.
> - Add patch 3/3, a fix for -net, a bit unrelated but discussed when
>   working on part 1
> - Link to v1: https://lore.kernel.org/r/20230628144927.828117-1-matthieu.=
baerts@tessares.net/
>=20
> ---
> Matthieu Baerts (3):
>       selftests: mptcp: join: rework detailed report
>       selftests: mptcp: join: colored results
>       selftests: mptcp: join: only check for ip6tables if needed
>=20
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 454 +++++++++++-------=
------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  38 ++
>  2 files changed, 253 insertions(+), 239 deletions(-)
> ---
> base-commit: 5fca7ce8c3c8d7badac7a9dd8b552bb221d91ee4
> change-id: 20230621-mptcp-issue-368-selftests-subtests-3c29a649dcdd
>=20
> Best regards,

Series LGTM, thanks Matttbe !

Acked-by: Paolo Abeni <pabeni@redhat.com>

