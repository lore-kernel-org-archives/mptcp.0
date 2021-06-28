Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440970
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624868574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfbf0q6N4YJ3ZB/zpvQoM2U9tRNz7A0FXI1DCovCZlQ=;
	b=d4IzihVmgaQQW2wYIMEg0pxUlXTwY7Jf1xLmFlknSZatlCO9R2s8d8XSqnMmAk4ZXEmFRf
	xlOmJile0y5xflp6zUMeoD4jOCxKSDl2MuioWjO3tk8pnoAGuK5/4QFv4EMnmXcR3IPmcZ
	0XrWN5kP1VpR3G+jGpTd48f+qdZML50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-kMZq9SphMBao6s9EWFWOkQ-1; Mon, 28 Jun 2021 04:22:52 -0400
X-MC-Unique: kMZq9SphMBao6s9EWFWOkQ-1
Received: by mail-wr1-f69.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso4327354wrh.12
        for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 01:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Hfbf0q6N4YJ3ZB/zpvQoM2U9tRNz7A0FXI1DCovCZlQ=;
        b=bpZWtDPGCUz0Jeg+8EZ7+KekLmzthBr2+UvJ6J06jbiSwMMoUqFzAum68oQuoHTJu+
         BwbgL+AK5GDSHf9DDwIqb2mdnGvgI5EhP3xXUau4Uv67+sGWT887AFxXWn0Vq+6lDSvJ
         FbagRwVU9HeJM9tD2Dg9Y+ol7yztlFnb7kvQ9THIEMFX9qYyzKdLsd1pKsAFLfmWa95r
         5AYOhdNPPVKK0u3Kia7jivyl/DV8fzWbmB846G/lGB+z3+1v3LjnQJJWH1R9ORSlp7tm
         SxmZEcoVK80PV4DmVr1T0gVURUG/gu0yOgEm/7YBPwcIXX1713YEGGEo+AAEwKCJxcAC
         QGZA==
X-Gm-Message-State: AOAM5316ozLnzvqtoYY9OSKVpswa7PW9arNGp2JHkyf/4CwAf7YI/rUS
	ln6sMgeK7zfylDh9CiFV6Cq51ylIOoSRQp1JY3SLZn0f0KNwFzH8lPgn8P/yy3X5P+CIB/ME5hm
	afjfj0CWoN4fNzm8=
X-Received: by 2002:a1c:e907:: with SMTP id q7mr25143313wmc.1.1624868571634;
        Mon, 28 Jun 2021 01:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/im28MAWluQn9OsVs7Z3xj/WK+OmNVFNYJtVqrY9eJACxlCeFAB/EBM3dI/1j9qXOGGfrYQ==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr25143303wmc.1.1624868571499;
        Mon, 28 Jun 2021 01:22:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id a24sm18722086wmj.30.2021.06.28.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:22:51 -0700 (PDT)
Message-ID: <5a265895487d8f61c30b9495bada893f92a8baf7.camel@redhat.com>
Subject: Re: [PATCH net-next] mptcp: fix 'masking a bool' warning
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, davem@davemloft.net, 
 kuba@kernel.org, mptcp@lists.linux.dev, Dan Carpenter
 <dan.carpenter@oracle.com>
Date: Mon, 28 Jun 2021 10:22:50 +0200
In-Reply-To: <20210625212522.264000-1-mathew.j.martineau@linux.intel.com>
References: <20210625212522.264000-1-mathew.j.martineau@linux.intel.com>
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

On Fri, 2021-06-25 at 14:25 -0700, Mat Martineau wrote:
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Dan Carpenter reported an issue introduced in
> commit fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf") where a new
> boolean (ack_pending) is masked with 0x9.
> 
> This is not the intention to ignore values by using a boolean. This
> variable should not have a 'bool' type: we should keep the 'u8' to allow
> this comparison.
> 
> Fixes: fde56eea01f9 ("mptcp: refine mptcp_cleanup_rbuf")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>

