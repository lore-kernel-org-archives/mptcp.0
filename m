Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07771849
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1649685002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSQX4x5ILJ0xx1bqaPr89M0HpEyAHrCawDcra7pPOnc=;
	b=bayaHYHCFluup5Xqod6/kPpzPBYlqMjgsVXnH+xXfsiDIwd7beXkTI6Cd4Yc0+MdAWtm66
	pAaBr7LMulSBuJAnFLlLbgCQEKA+CitiZjjCeHt9MY73vYansccYaHMRVDpFTxbeqsEdGH
	MCDTZ+wPWfiDkmIvFFASk69vGpyyJz0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-1J3xPeMWMSmiYZX39wDKlg-1; Mon, 11 Apr 2022 09:50:01 -0400
X-MC-Unique: 1J3xPeMWMSmiYZX39wDKlg-1
Received: by mail-qv1-f71.google.com with SMTP id o15-20020a0562140e4f00b00443dee06cc4so15777110qvc.10
        for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 06:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hSQX4x5ILJ0xx1bqaPr89M0HpEyAHrCawDcra7pPOnc=;
        b=wksY8GmL/VNHXVPKh8EWBWdTEb5NF35/b21NRYeIl8dblsXwzaGl9NXJqbx3G8m/+D
         suDLks8BO8dwwwLcmnwqrsb3riuoBP4zwNbXdWtqsQMKIN7hz8ozG3wSamLe2DdZKHW7
         xiX27amTzmCSMUS1qkylwjvo4QAH45dW0xEx780LYtgUlNfGGIR65CJrJA6A5QEDeJNE
         vSiHAKlTkoTVU0OedtEshrvLpjSbQ6zesEIouqK1wzFm5MZZmaRR2LsREHHDXmdTgtZK
         598AWP2uAltxaYFtwwAVrBp2WjisE/loZNsrDHidKexZt2rZVFUGpvxCVy8r4JNeNlPu
         4fWA==
X-Gm-Message-State: AOAM531Twajia4GAJWBSwPnUMQIgMXnILlz65kesr8+jAsF4uqJgcd3x
	BB9ITwTV+frcN/HQv/83cvFd9iYrA36NDWtwqPqQ3oJwzHHuwwaoxra0amDRjsP/o4I63/yul2D
	jBQRnefmUyrexBaJ5WtoYBneyBSYidm7bqnlq8pCDKewEWkpvZqntT54z6CH+0a2Z
X-Received: by 2002:a0c:9045:0:b0:443:cec9:e349 with SMTP id o63-20020a0c9045000000b00443cec9e349mr26799372qvo.88.1649685000417;
        Mon, 11 Apr 2022 06:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYuui/tzAK/XgWSjSOJjP+7K1u5LrnXjioJEBEFbvDfZyfkW7DY2aOutpKSGsPnMR7stpMFw==
X-Received: by 2002:a0c:9045:0:b0:443:cec9:e349 with SMTP id o63-20020a0c9045000000b00443cec9e349mr26799348qvo.88.1649685000034;
        Mon, 11 Apr 2022 06:50:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id i62-20020a37b841000000b0069c10d27571sm2947606qkf.70.2022.04.11.06.49.58
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:49:59 -0700 (PDT)
Message-ID: <da9c99ac17bb72890feaed6969fe582da8494d85.camel@redhat.com>
Subject: Re: [RFC PATCH 0/4] mptcp: improve mptcp-level window tracking
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 11 Apr 2022 15:49:56 +0200
In-Reply-To: <cover.1649672265.git.pabeni@redhat.com>
References: <cover.1649672265.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Mon, 2022-04-11 at 12:40 +0200, Paolo Abeni wrote:
> Note: still in patch 3/4, I'm unsure that the th->window update is
> strictly necessary from functional perspective (e.g. possibly the atomic
> operation is enough), I'll try to test that, too.

A couple more notes:

- it looks like the th->window update is necessary, a test run without
the relevant chunk produced significantly less good results.

- this is still (supriese, surprise!) not perfect, I can observe
low_but_not_zero count of TcpExtTCPZeroWindowDrop, which instead should
be 0 without evil middle-box (and is 0 with plain TCP)

- I'm wondering if we should additionally add another mib counter for 
MPTCPWANTZEROWINDOWADV - quite similar to TCPWANTZEROWINDOWADV

Cheers,

Paolo

