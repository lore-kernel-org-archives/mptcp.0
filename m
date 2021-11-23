Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C172
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637693343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7XltIPpqUDW0NfLTonakvlMbkbPzTeqW4iXAks41GQ=;
	b=cCL1TfLd11APz/wRYIBjUO3ieDHutTqsEEJyql5w4Mi4UtRkT7fWxt7gbrKOVGI1axUlmb
	YYiaip8tHbkhiVbUlJPYEHyle9BBt4HJJSVlhYJMkbcjyl52aCsOtsRpcNYlpR6BvNBRFe
	UhLf4J0X8q3ltJZz6aHjXVNAaOStvZw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-EPiEmGqKMmC5cxVtJ3O0HA-1; Tue, 23 Nov 2021 13:48:59 -0500
X-MC-Unique: EPiEmGqKMmC5cxVtJ3O0HA-1
Received: by mail-wm1-f69.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so2001592wms.6
        for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 10:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=h7XltIPpqUDW0NfLTonakvlMbkbPzTeqW4iXAks41GQ=;
        b=FQ+clPaAAu0Qw5UV3rKm3vM919Rag3mgVVM6HAVTgVQcJpyAtjnVnZgsX3HC+SVkYT
         kDvIv5H66ySIC2s1WaGNit40kj5RbweR8zg6ORHLmXWCEwL9OoWc+Qi4NB+RvYFMkGA6
         KwmSTaxo2Cy/tm9eaEpTP97kL6nYZId5hyytGJ0gJ3tU+vwd+4wybz3M9x1VFKms7mcc
         RGjjHIsDvqPWFumbvD2JDiTyrm7jOPPapQRWEgsqkuEg1xaCJuaPc14oJmnf+aMM0M7h
         tyP2vlut7L0D+uZdBvdnvYQC2CXYurrJrzZNLxL+hmC9FyoazK0KKqhSnzBOMY7I5nxU
         8hEQ==
X-Gm-Message-State: AOAM530jFVVMa5Kp8ajmZEwunQuoOU7m2X1BDZ0rUDhlIhlJ7cju5HvH
	x65x+2333D7fvI+XAavPkjikMxpnwcbH0QrHvWI3bqMbjtBVjcuNu2g/bcU1kRmTMqqT4lcOyY7
	11lbSelU30FbgLPAp84XwUEUTQXDRQQawQ+lBJI4Wzx6dNd/rBaJaGqSLo4m0J15a
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr5920093wml.0.1637693338595;
        Tue, 23 Nov 2021 10:48:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoQG79Mmi9fcoX8Y1mF6+i2dQZXsekmsFOwWJyyxitPL9zya+xT9T6I6r5/8dvT/sDgWfbqA==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr5920054wml.0.1637693338343;
        Tue, 23 Nov 2021 10:48:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id j40sm2483077wms.16.2021.11.23.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 10:48:58 -0800 (PST)
Message-ID: <f4b05d4a330e7286fbb333f03c36e1ca4d9386f8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: improve subflow creation on errors
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Date: Tue, 23 Nov 2021 19:48:57 +0100
In-Reply-To: <cover.1637684792.git.pabeni@redhat.com>
References: <cover.1637684792.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Tue, 2021-11-23 at 17:37 +0100, Paolo Abeni wrote:
> Currently when a subflow connection fails - either the TCP
> connection is reset by the peer, or the MPJ handshake never
> completes - the in kernel PM don't perform any further action.
> Notably no additional subflow creation is attempted.
> 
> This series is aimed at improving the in-kernel path manager
> behavior in the above scenario: on failure we try to move
> to the next subflow, if any.
> 
> The first patch is minor cleanup, the feature is implemented
> by patch 2/3. The last patch adds a specific self-tests.
> 
> This should possibly address/close:
> https://github.com/multipath-tcp/mptcp_net-next/issues/235
> https://github.com/multipath-tcp/mptcp_net-next/issues/242

Uhm... I actually missed a few points from issues/242. This does not
address the latter, yet.

Cheers,

Paolo

