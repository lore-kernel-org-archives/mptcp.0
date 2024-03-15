Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39D18027
	for <mptcp@lists.linux.dev>; Fri, 15 Mar 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496000; cv=none; b=Jf9SzehdFfPz5g3EHP0NbsY4tiHYrNxW5P4UMXM/b0XOPSk26XvFh7tOy0trt9xqH1CPKwuQGAhw5yTReDqtP4zHFBV5UfE3x5M5zaYHe6LLPzsy1W3I6K/4BY5FAr4G/597kqVKShXwWh4DsoVs6JftVZIOsoJ/3zU3ro/vD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496000; c=relaxed/simple;
	bh=de/DHXJns6jhbK+b9nDwO+GmO9dmJ47k3bXJqhiexlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmDVTyFYOtQ+N6pfxaCIxtspXh0vBND/GbcZQcrWIh2OMqikAboKeuYciQF/ovSLB7xZL6M9ZjjpKxu37SJdz0VZm+dVVgrUbu8jdcMxQHvu5T3Zu+nWhz92EugJGG22V092ASJdSDHu+lRpufuXATRG6Ff5GzGY+qRiahVevNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xi5ZFR/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xi5ZFR/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710495998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=de/DHXJns6jhbK+b9nDwO+GmO9dmJ47k3bXJqhiexlI=;
	b=Xi5ZFR/sN7bGSKfjZA5AxOP0Y3p3kCO+kL3zHzZfM97/+Q81RBJh81t0LhZ7PI0E4VrANH
	qCu3n7RG4QmsPd7AsTZVUWPkCDUcGfzpWErPq5AYVxeGth8+vp0J8gKB4KC1VR04fusv+v
	ewbioKhBdSI5mOu/15sUWxPVpRr+HOg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-JBxOYBEvMsmicT4nb5JndQ-1; Fri, 15 Mar 2024 05:46:36 -0400
X-MC-Unique: JBxOYBEvMsmicT4nb5JndQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d4858fff42so7736701fa.3
        for <mptcp@lists.linux.dev>; Fri, 15 Mar 2024 02:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710495995; x=1711100795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de/DHXJns6jhbK+b9nDwO+GmO9dmJ47k3bXJqhiexlI=;
        b=dXfBaPiVmCr0ObWFGPlPxJocqNJzF1J3wclSyf7Jfcb659IZo0RdMvDZNF4JiRymLw
         fJ85bGOJpQwv4qBGr9U0Dpq7c2+NXNMIKkSFxhUo1me0bnRjoqGx+nAjTz7u/f/sLegM
         xCmbS1Y5XAyAQ9cTt2r+y1dgVgND+7nHjXJiBdBfUA9FzSJDQwxaPjbB/04OlkG8I5b7
         MrD5zvRzd2KTdc9d4ALQoXBaWW2al0Fxu5CjZv2h0jKDBOPPUnvPxQj50T3EOGD1SgIY
         XAyok7Oo3kquNlPXuIAMWBCBhZQdXsSManyvlhhs18wyXtY1m8DuSQa28kVVxhgf4qPU
         B1GA==
X-Forwarded-Encrypted: i=1; AJvYcCWmCE9pBDckhXEmgYlnlj3UwMuq0OD7V6ypnS8T9NNOL/q7evtJ9FW6m0s/CjOk/p2/JWcR3c3JChAJqIlEjNHo/qsIDcI=
X-Gm-Message-State: AOJu0YxiML7wHCsnrrMjbgOm1Xi0nxopwMFSl/RsKcHF4TvWdWfa6mvi
	d5p3dH4mjJnGOueS5JDLMdpIE31vczuifo0vU291PNHwn2EfBc+dXtRlePPayKdRhpwbZn4GKis
	LSvho8Y3b2527iyz7fqhx1X3ea/wZEP0uvwRiAG1ACili8/gDf0joEbdlGtXzPj9BiLnzXDWjzV
	71vA2cl626QiLHJng86UOfz0C2HD0=
X-Received: by 2002:a2e:a412:0:b0:2d4:5f50:1fa with SMTP id p18-20020a2ea412000000b002d45f5001famr1666606ljn.41.1710495994738;
        Fri, 15 Mar 2024 02:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmCl6lLHXMH/wVMpEDUaejh6wUygcQhOEpyJIThEAL7X1JeBweQcO6+qbGSli7z56scCmbjuo8J4Pg5aoQYBM=
X-Received: by 2002:a2e:a412:0:b0:2d4:5f50:1fa with SMTP id
 p18-20020a2ea412000000b002d45f5001famr1666592ljn.41.1710495994264; Fri, 15
 Mar 2024 02:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a5f63fbcf13323d8cf293f42849673093d1bf45b.1710179839.git.dcaratti@redhat.com>
 <145aa063-d762-8933-7c1e-b611dcc9525e@kernel.org>
In-Reply-To: <145aa063-d762-8933-7c1e-b611dcc9525e@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Fri, 15 Mar 2024 10:46:23 +0100
Message-ID: <CAKa-r6uT6+2ho4t+M0P6WC=pTGANj=drXVrOYjX2dbmn3bEb_Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Mat, thanks for reviewing!

On Thu, Mar 14, 2024 at 1:46=E2=80=AFAM Mat Martineau <martineau@kernel.org=
> wrote:
>

[...]

> This prints:
>
> [FAIL] pure TCP counted as fallback (expect:%d, got:%d) 0 1
>
> which I don't think is what you intended

yes I forgot to convert the old argument I used with printf: will fix
that in v4.

Thinking out loud with Matthieu: those "if" tests on client and server
protocol can be removed, mptcp_connect is not expected to fallback to
TCP at all in that scenario. So, whatever 4 combinations you can make
out of $cl_proto and $srv_proto, that MIB shall not have an increment.

--=20
davide

