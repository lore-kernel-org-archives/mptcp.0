Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6752C83
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633603669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JdUIWkzbqZe9vbicZQzDJ9xS2CLdsi+R9x4i00e0XE=;
	b=Iff+eWCXi/tW2OEthh+fznVInq848hzsUrhylaCFDQbE7YNHLYwm+jKPuoGDm7bt9RFXMo
	wAntdi6+bhIcSJpSY+ar7+8d3xPQmt4fBBVg7WHrz32RUip2EmkNGdVD3V5EbZU3/suSAw
	tUPpk16scUs0PU8H1VmgxL8IyyvxPgU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-Gl3Fj9fOOkSwk560bKOcFQ-1; Thu, 07 Oct 2021 06:47:48 -0400
X-MC-Unique: Gl3Fj9fOOkSwk560bKOcFQ-1
Received: by mail-wr1-f69.google.com with SMTP id s18-20020adfbc12000000b00160b2d4d5ebso4374806wrg.7
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3JdUIWkzbqZe9vbicZQzDJ9xS2CLdsi+R9x4i00e0XE=;
        b=PJ/FBRZ5FkMKYTxRex80X4p/5kMKkNOVSVlWag7SjeWjc3AGMV4EIPbu4o5x7vKgwu
         iLC2KH0zfylYkGhTawmptSZDIqSZea+qF2rPpeG0AhwKvaM69arcLcRitWd7mg3AvX0R
         fbxE8wq4vjEZGxCL1IFhV7Pu6ZNcFBRV+WuSk4QpOZwLa523AKorOUAOjPeT3/utzzSW
         Twj+f4ZjRG4Hvy8SOPh5iiqFs4srL1xNWb3dWYDdoewRHOTpwBNkKeLKCn2MKXaE96FI
         gFl0+tMQBMqjjDTb3gfwW9nhQDKb762jZQjD70r7NZw6JgEIn0OsZGIORSpaO3zm6L/j
         xwqg==
X-Gm-Message-State: AOAM530LcD2fbSOUv1xuj/1ZKrz1N0FvJf39XA6lLfZkPPtmD9S/BkyO
	/eTJ8pk1L4b1bClKJospSk/y6vlcXLd0WjSBBpXztDWsQvokxFpY6YRvMPEh995L0EN3XC0zvyN
	Esli4mwqkDwJ5G6o=
X-Received: by 2002:adf:f30a:: with SMTP id i10mr4451096wro.65.1633603667193;
        Thu, 07 Oct 2021 03:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF2YNxWgKaUTYL3g3INABiAuM8/KIGcHInrDfv505N//zJw9jY4fbAQmdqlyKyc//dx2dAJg==
X-Received: by 2002:adf:f30a:: with SMTP id i10mr4451079wro.65.1633603667054;
        Thu, 07 Oct 2021 03:47:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-183.dyn.eolo.it. [146.241.225.183])
        by smtp.gmail.com with ESMTPSA id l2sm8395270wmi.1.2021.10.07.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:47:46 -0700 (PDT)
Message-ID: <9e4fcaebd4ade9c525796cb3df5a1e6acc323563.camel@redhat.com>
Subject: Re: [RFC PATCH 2/4] mptcp: selftests: MPTCP_PM_CMD_ANNOUNCE
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev, 
	mathew.j.martineau@linux.intel.com
Date: Thu, 07 Oct 2021 12:47:45 +0200
In-Reply-To: <20211007043656.261552-3-kishen.maloor@intel.com>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
	 <20211007043656.261552-3-kishen.maloor@intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-10-07 at 00:36 -0400, Kishen Maloor wrote:
> This change updates the "pm_nl_ctl" testing sample with an "ann" (announce)
> option to support the newly added netlink interface command
> MPTCP_PM_CMD_ANNOUNCE to issue ADD_ADDR advertisements over the
> chosen MPTCP connection.
> 
> E.g. ./pm_nl_ctl ann 192.168.122.75 token 823274047 id 2345 dev enp1s0

We need an actual test case with the above, likely in a new script.

Thanks!

Paolo

