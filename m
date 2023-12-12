Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674B5B5D5
	for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL7k6+ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702405714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IO8//ck1ydOpcdOqve9O1peJ0pMgYh80N1pyfBjiPRc=;
	b=JL7k6+wsZh7L/I0BBPjbsL1cB3o+b5B3/FQcGBcYjNHwm0FjisNGqROG8TD0cTjp/2Y1lu
	FLD41QNhsSqeKfk8kHL4aY+8uoPwu2Fdd2eeH+zHLePlRYLsZzERBOpXCCYaSsz/1nmRq8
	4wlNM/k+tR7ZuVesx/3eoQbyx/Pde0c=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-F2-bXvrpOOm7yJGQhmFOWg-1; Tue, 12 Dec 2023 13:28:32 -0500
X-MC-Unique: F2-bXvrpOOm7yJGQhmFOWg-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-464856836fdso686985137.0
        for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 10:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405712; x=1703010512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IO8//ck1ydOpcdOqve9O1peJ0pMgYh80N1pyfBjiPRc=;
        b=q+CtqlRZFx8UrncZ9r6vtJa50UVoeUVu4Pb5ZLhM6UkphiYSnRnTVC7FeOfWY5jsFW
         T/1AcGMtfGOREBFMNs8fssF7WYdxkOuVQuktOwhP7Wf0Orry9H9231yq8wFxSDNjpLb8
         r/v5yWo3vxeJll2zP26FAWzJlnF8r+YMAUXmMuxIWHL8Z7+YlI06Clovz9/Ne6Tz9njS
         JRPomUpQiLnGEskGyfrIfFgNUoJ8Q2sZb5kK/r54h8DbmR/Wu02Li/Q50L4lXxrC1miy
         LH/waKgXP/Pyqn+HzzPyEdd8DKx3KOMYz3JCiEgbPi+CdZGbDRpkLUGxYiA3oVF06loO
         WFaw==
X-Gm-Message-State: AOJu0Yx2UQxybnUAhlt5aPGf3++Gz+B9/wPDWCS2d9MDQMIarWWqzeQi
	sO2UNLfe11OfStXhCTI7HR93JzOoPEpecIi3HsnPJrI9VR6zEGuYvHchqliqTQ9QL+wIrlSGz0y
	CxZ9LtZHdBSMVJQ4=
X-Received: by 2002:a67:ef86:0:b0:464:8891:d315 with SMTP id r6-20020a67ef86000000b004648891d315mr8166493vsp.1.1702405712247;
        Tue, 12 Dec 2023 10:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYM1M4xZ39YIXkxBjEeaHrenQ7aBZXlZ6unu+G+e8I+5ByzTjM+QInBjLdCBYIYNdwJ7nIJg==
X-Received: by 2002:a67:ef86:0:b0:464:8891:d315 with SMTP id r6-20020a67ef86000000b004648891d315mr8166480vsp.1.1702405711979;
        Tue, 12 Dec 2023 10:28:31 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id w12-20020ab0650c000000b007abc40a9543sm901927uam.20.2023.12.12.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:28:31 -0800 (PST)
Message-ID: <5d2f53bbf89f2c3626b76caeef30fa5965f79f28.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: don't overwrite sock_ops in
 mptcp_is_tcpsk()
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 12 Dec 2023 19:28:29 +0100
In-Reply-To: <dfaab45e985a326de8bd075ced1ab39211521939.camel@redhat.com>
References: <784668db3e21351c91f4f312720059c6fa5cc15d.1702290281.git.dcaratti@redhat.com>
	 <dfaab45e985a326de8bd075ced1ab39211521939.camel@redhat.com>
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

On Tue, 2023-12-12 at 17:56 +0100, Paolo Abeni wrote:
> btw the CI failures look real, but unrelated ?!?

They are triggered by a recent upstream commit:

commit 3d501dd326fb1c73f1b8206d4c6e1d7b15c07e27
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 5 16:18:41 2023 +0000

    tcp: do not accept ACK of bytes we never sent

but the root cause is a pktdrill script bug: the ack field was not set
correctly on some injected packets. I'll send a patch.

Cheers,

Paolo

