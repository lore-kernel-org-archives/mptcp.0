Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973B63B5
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686157745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHRuPpKPlGk4eYZ8yP2E/uCqrOfmYufEJxs+TyDhIgg=;
	b=ZA1nhILNggSOB6ClYkuEZCTu9fu1VB3HypUQIpYpzzq7EPpVYC3AuC1OAo7vyeDUpGsOop
	awvkvh7DGrzWANHdTswfMlGr8EYo3KrVVbNWsSpjI/mcv/bSu6EPPxx6R8BaTX5u/+Myao
	iMnXh4Txrh4B1V83yAbEQJXVRPwcvLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-wcr0ED8lPtaIzuReF5oAew-1; Wed, 07 Jun 2023 13:09:03 -0400
X-MC-Unique: wcr0ED8lPtaIzuReF5oAew-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f08900caadso14208905e9.0
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 10:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686157742; x=1688749742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYhAXOokLH4QzZtgPP+1f9OOtF68S0MzisFQlCzY3pk=;
        b=lC9h3/0+EPCOZPLAsm0jxzdoWhG57Ph8nQ8hWwA4nFV8lmNnl81+Yudc3r18ZO2tf9
         JwNfmBSIt2tu5G7JbvQEvzFxaGXMebaYWpGmivbHQjfWbndKnU/v+mf537bvZUa5CR+Y
         nvAyLFsGWSUbftlemJq5mC5MAjm1cCIYY6Zwx1R3V0RBXFGDstsUahvliIZlZyHd9gLF
         9ct95RLJvDUJ0DYHA5lW7ilH+v371vha9AbIoMFsSVEW3+fER4Ta5lgfSCX/QskwnwrM
         DtE6E4osK3D2Q+DM89YA+6tUQChCVBP1cMMQzymalu7dWPyq+sUNSVdZF2mQ05bl++7D
         6B7g==
X-Gm-Message-State: AC+VfDx25mUTfsdKhuCwBbd+FGfDYBbgbqqnl6iE/tVFsqu1vJ+F+k9C
	kimv435emSeCLTFoHrs0uHdVJ1PmI1kR7lmiO6BsEHsjJVDlvyOCxKApmOEAoVlItdvYIncndEr
	Lgi/xRNrQERsBp34=
X-Received: by 2002:a05:600c:3549:b0:3f7:e8f9:867f with SMTP id i9-20020a05600c354900b003f7e8f9867fmr2432162wmq.2.1686157741811;
        Wed, 07 Jun 2023 10:09:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sXCOee+1HVFAbNFg1sywqtCwopmmmPz4/xjn5SZpBSlNjWCupfZMRrF4uIJTPyzhm8BIZGA==
X-Received: by 2002:a05:600c:3549:b0:3f7:e8f9:867f with SMTP id i9-20020a05600c354900b003f7e8f9867fmr2432151wmq.2.1686157741453;
        Wed, 07 Jun 2023 10:09:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-199.dyn.eolo.it. [146.241.247.199])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b003f6cf9afc25sm2708240wmi.40.2023.06.07.10.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:09:01 -0700 (PDT)
Message-ID: <f18a8bad95754fae7a9c0cae48583279c62b78b3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v7 16/19] selftests/bpf: Add bpf_burst test
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 07 Jun 2023 19:08:59 +0200
In-Reply-To: <2dfff62f24fc147fd736d452b72977c90406dca9.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
	 <2dfff62f24fc147fd736d452b72977c90406dca9.1686127032.git.geliang.tang@suse.com>
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

On Wed, 2023-06-07 at 16:38 +0800, Geliang Tang wrote:
> This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
> sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
> devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
> command to add the new endpoint ADDR_2 to PM netlink. Send data and check
> bytes_sent of 'ss' output after it to make sure the data has been sent
> on both net devices.
>=20
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testi=
ng/selftests/bpf/prog_tests/mptcp.c
> index a968641cc94a..b9f6dcf995fd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -10,6 +10,7 @@
>  #include "mptcp_bpf_bkup.skel.h"
>  #include "mptcp_bpf_rr.skel.h"
>  #include "mptcp_bpf_red.skel.h"
> +#include "mptcp_bpf_burst.skel.h"
> =20
>  char NS_TEST[32];
> =20
> @@ -455,6 +456,41 @@ static void test_red(void)
>  =09mptcp_bpf_red__destroy(red_skel);
>  }
> =20
> +static void test_burst(void)
> +{
> +=09struct mptcp_bpf_burst *burst_skel;
> +=09int server_fd, client_fd;
> +=09struct nstoken *nstoken;
> +=09struct bpf_link *link;
> +
> +=09burst_skel =3D mptcp_bpf_burst__open_and_load();
> +=09if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
> +=09=09return;
> +
> +=09link =3D bpf_map__attach_struct_ops(burst_skel->maps.burst);
> +=09if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +=09=09mptcp_bpf_burst__destroy(burst_skel);
> +=09=09return;
> +=09}
> +
> +=09nstoken =3D sched_init("subflow", "bpf_burst");
> +=09if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
> +=09=09goto fail;
> +=09server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
> +=09client_fd =3D connect_to_fd(server_fd, 0);
> +
> +=09send_data(server_fd, client_fd);
> +=09ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
> +=09ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
> +
> +=09close(client_fd);
> +=09close(server_fd);
> +fail:
> +=09cleanup_netns(nstoken);
> +=09bpf_link__destroy(link);
> +=09mptcp_bpf_burst__destroy(burst_skel);
> +}
> +
>  void test_mptcp(void)
>  {
>  =09if (test__start_subtest("base"))
> @@ -467,4 +503,6 @@ void test_mptcp(void)
>  =09=09test_rr();
>  =09if (test__start_subtest("red"))
>  =09=09test_red();
> +=09if (test__start_subtest("burst"))
> +=09=09test_burst();
>  }

I would be curious to see how the ebpf scheduler compare with the
build-in one performance wise (max tput on 2 fast links with a subflow
on each of them). The link should be fast enough so that the tput will
be CPU bound.

/P

