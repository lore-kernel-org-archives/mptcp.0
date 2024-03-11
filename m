Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152683D551
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164579; cv=none; b=QltBliadvmzBVEc23eldQOPWhWimCvLUzkBv7rBE9FhtAqCgxr+YrGwB+zFC/c1paax2tPTBePwlpoiOqTIrSkjNuf9mpJ6TIDLHzckgR+ivXimpcOqgf6PNKV5R6FKw272pqsJUQ+cZ+zyL0gj+bg8cdDidIOdY5I0tNs8C+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164579; c=relaxed/simple;
	bh=n2p27mGLXf7l4aVsbWGLoKf0Qn4Bdwjrn3XLSwVbVcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQoP8pWL/CN97HgVfUnDMZLpO87ALFVlIlx1zYqaZjxHw0Og6m1BJk8rAnVJaOBYHHA24dGA6EWYFy9QtpO7K9sb+xqM/+AFzqdkSPGzksaGWzM7QLsXED1QiVmqEOuU0POnqNW1eaHRB0Lqks+pajIvbyXqibJuCPmgHVhsIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iS7hPs8j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iS7hPs8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710164577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2p27mGLXf7l4aVsbWGLoKf0Qn4Bdwjrn3XLSwVbVcQ=;
	b=iS7hPs8jKapQxoktVatNWOmJnq5WyFQDYFop3fSl9Lnu+t7STChFXRN+OlV+dkPv4WpBDr
	ZBncKBBBW1xfQNmPudE1i4Io1dz2+L2ZWH5Bo2WdOlVOYnPLDcCOgD5ZA7aShPA4U9xrOr
	GWVOwIg+mPGC6hRLxidakP45oT5cth4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-RwBDx08kPCGn9KyU2RKB8Q-1; Mon, 11 Mar 2024 09:42:55 -0400
X-MC-Unique: RwBDx08kPCGn9KyU2RKB8Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5132027acc8so3527569e87.1
        for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 06:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710164574; x=1710769374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2p27mGLXf7l4aVsbWGLoKf0Qn4Bdwjrn3XLSwVbVcQ=;
        b=YouQsE4Uli9vuaRpXmAWs/tNUTriBHtaoMU569ocOGb+Tkpyc3eiWJ0u5c5bYCBS3o
         fokDbt3udkTD0Z/mePkf4bMtw6MIy0tlgjDf7akrQzaSlVW3cQySWQTgV4KOgO4YxJIw
         W41qJ4TGyLl6CAO5y5Yk6h/EaAILq26w7iwVq0MqpEdYZXjxWe8VOtRzRJWO5OfTwzqt
         O2DR05AxY2Devvah47G+2T79G23BMCfe9frl8tjXFz2ilWRKx1OmbV0BwWuCLVMQzesB
         7bRhT/4lR8Y7hEWZImGAtViEi+9U9wrTqUe5GYJ9tK0/hwavZeg3+FHM7C3mrKX8PY1s
         XmQg==
X-Forwarded-Encrypted: i=1; AJvYcCWrx+E0tpGTEBjPDAMDTyyd/DT3Y1naPEDeh3DtWVXB+2+FOz5JGMx6BE2OIplQ9cEjPUvZqpfwrOr6WC5KlKnV7e3cMNI=
X-Gm-Message-State: AOJu0YyiGZlWy3jv1izVXzW6zOUVADCw61eUI+hjrLNriMg3frWP3Pmb
	vXMXj1z8sFzm6HLUByXQwXpkd6FFkzGwCU2vRVKBbwlHzPXUooOS+gHxrgRCx3CEXnmNpCLacH5
	LPDboUNFwF0J6xKZnS6TUYQqGbFUIh3EBpDj3MEAxmYoXXTTbIY9LYOR/2++UCaM4WTN2SmMWQC
	8O+0v8RC+0VQZnHGSoxDSfQSwSGno=
X-Received: by 2002:a19:ee13:0:b0:513:1c6e:583e with SMTP id g19-20020a19ee13000000b005131c6e583emr3783577lfb.61.1710164573626;
        Mon, 11 Mar 2024 06:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzEgjv4xrRqcMk8i8Oc+t12qdZwkT/GkMA06rTg2n5s7YBFWpnpL+X78J+0CccMXEN5vw33ekVUk8oy+MEdXU=
X-Received: by 2002:a19:ee13:0:b0:513:1c6e:583e with SMTP id
 g19-20020a19ee13000000b005131c6e583emr3783556lfb.61.1710164573061; Mon, 11
 Mar 2024 06:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
 <62dd5009-fd83-4cd6-b7b1-8afff28a575c@kernel.org> <ZenfkXU_zYb0AcR8@dcaratti.users.ipa.redhat.com>
 <07323939-df11-4a2c-950e-de1412bb32b6@kernel.org> <CAKa-r6uQmQO+vD0UnkOHNbR-2EdxWoJArTpxMwJAiV7xC2Yz3A@mail.gmail.com>
 <636a37c1-ce8a-429a-a668-0c0abb125911@kernel.org> <Ze728xdGAhQIgHW5@dcaratti.users.ipa.redhat.com>
In-Reply-To: <Ze728xdGAhQIgHW5@dcaratti.users.ipa.redhat.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 11 Mar 2024 14:42:42 +0100
Message-ID: <CAKa-r6sm+0yd0ay7tLrjEjDc3z6xJYTX15oQHF+JEmnMPSJ-9w@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[...]

On Mon, Mar 11, 2024 at 1:20=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> hello,
>
> On Fri, Mar 08, 2024 at 10:54:31AM +0100, Matthieu Baerts wrote:
> > Hi Davide,
> >
> > On 08/03/2024 10:14, Davide Caratti wrote:
> > > On Thu, Mar 7, 2024 at 5:33=E2=80=AFPM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> > >>
> > >> Hi Davide,
>
> > What about also checking in mptcp_connect.sh that the counter is no
> > longer incremented? I guess it should always be set to 0 after the
> > patch, but it was not the case before, no?
>
> correct. that would result in checking that $expect_ackrx didn't
> increment when $cl_proto is "TCP" and $srv_proto is "MPTCP", right?

^^ scratch that, it's the wrong counter :) we need to ensure that
neither MPTcpExtMPCapableSYNRX nor MPTcpExtMPCapableFallbackACK had an
increase after

./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} <...>
./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} <...>

when client is TCP and server is MPTCP. Let me try a patch for that,
then will post v3.
Thanks!
--=20
davide

