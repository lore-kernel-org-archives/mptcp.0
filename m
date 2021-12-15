Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E60668
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639581046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdMHzVfLiujMkYMh+oRxzH8cR9zgrwiA/9RJGLxgnsE=;
	b=abISGOokqAdKNQ8OMxA5AIy35QRPofR1rAcqJUsr/8RT7xnNnTeJ+5CfZFyWrzKKv53zWB
	VqjjCAXLlaEjqf1R2LU2gtihzZ/vvyF9fYfH2vmKz/HHZJCiKGO0dc0z+UTiCRWqKl91p0
	F29aD8sWLZk/jes4I7cnH2qY6AOEiI8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-XG7cgd29OrqWOyQd9iJXLA-1; Wed, 15 Dec 2021 10:10:45 -0500
X-MC-Unique: XG7cgd29OrqWOyQd9iJXLA-1
Received: by mail-qt1-f200.google.com with SMTP id w14-20020ac87e8e000000b002b6583adcfcso30332119qtj.0
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 07:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mdMHzVfLiujMkYMh+oRxzH8cR9zgrwiA/9RJGLxgnsE=;
        b=2qqCJh2Xnlf+edvFLABOicGrXrMhwZIMlR4FkcLFwrCxhGK1Tr+Vd4iyXx2Oh09Avy
         RdumbKlj9zrUulteW1iYhJBwjE0wLVFdTjTzQNTqdUweIJVDhfvgGbvvf+MQ1j1MazKq
         nyVqm6+bO4pU+/MmqHx2RRWPzW+QNmQGeabE5H+iNkuIHtHz7ZkWZwBPfcor+EFcOimk
         yQG9sW+NzP85rOfY8G4Ntq5SORD9z7+AoSAVIe350IU6dgnRb+ghtGCA8DY/MELGsaaD
         ab7QY0uLtOnQ3pWcEXRuxR8oJO2ZuUfjK+1CSbQBA6ebCMqhyXAcyEg9vqIRaTPizNOZ
         c/LQ==
X-Gm-Message-State: AOAM533p0Ky3UEy2DvM03QLD9bOKcfgPS85jtsK1nRBJxdRoo7lwUSXZ
	enmtmAuyJYlenZtg7g/4kytdTjpAYyzTYuNha/cv5gyRUGZebJSgP3rtW8oNkY+bgmece10ZbTr
	X/p3zK50Ao6+Rr/jBQnWj1MsBEmXHcLbFr24DXzlRy9ocQdiY6fCF1YDcQhcPNTdn
X-Received: by 2002:ac8:7203:: with SMTP id a3mr12534253qtp.666.1639581044421;
        Wed, 15 Dec 2021 07:10:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfWe6bgbQiNg9tk9bBsamEDvDSdE54qYTztMjmVPhDrmSYZsMR80fWzrfqDygAb2OCDCnbSA==
X-Received: by 2002:ac8:7203:: with SMTP id a3mr12534221qtp.666.1639581044041;
        Wed, 15 Dec 2021 07:10:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id u11sm1685057qtw.29.2021.12.15.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:10:43 -0800 (PST)
Message-ID: <e18d05b18db309488061f64af8619c3cdcb37534.camel@redhat.com>
Subject: Re: [PATCH v6 mptcp-next 7/7] mptcp: avoid atomic bit manipulation
 when possible
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 15 Dec 2021 16:10:40 +0100
In-Reply-To: <c813c051e41153bbea3c7881acf81bb175e06fd6.1639500873.git.pabeni@redhat.com>
References: <cover.1639500873.git.pabeni@redhat.com>
	 <c813c051e41153bbea3c7881acf81bb175e06fd6.1639500873.git.pabeni@redhat.com>
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

On Tue, 2021-12-14 at 17:58 +0100, Paolo Abeni wrote:
> Currently the msk->flags bitmask carries both state for the
> mptcp_release_cb() - mostly touched under the mptcp data lock
> - and others state info touched even outside such lock scope.
> 
> As a consequence, msk->flags is always manipulated with
> atomic operations.
> 
> This change splits such bitmask in two separate fields, so
> that we use plain bit oper operations when touching the
> cb-related info.
> 
> The MPTCP_PUSH_PENDING bit needs additional care, as it is the
> only CB related field currently accessed either under the mptcp
> data lock or the mptcp socket lock.
> Let's add another mask just for such bit's sake.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This patch has still a few issues - basically it lacks a bunch of
BIT(). @Matt: could you please apply patches 1-6 (with modification on
patch 5) and leave this alone? I'll try to send a new version soon.

Otherwise I'll re-send the whole series.

Thanks!

Paolo

