Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757883;
	b=ZaQPWW7l86p7ySmrU4HTueKly+ZGElfjhiWJI8qdv2dqqv6rXwtA9bcXsosZPtu8U8ga
	 kv/+8+2WNwfCOCHrtH3yF0/qwU5wr08aO42a/sFjC31PmPauyi5/od1MVtzhhQeio41cc
	 Z2z03S1tz8Kaq7uXQoG0liQOouMnPg0uqdjckdS/kMVaOoRuQOA9WfYvT5UqhdLW/Lgta
	 jkNcfW8YQ5cz2DrCR8Vb7B50XRKi5kZ2boDqnH0/Q1B4O7CXtDHsRT9J5IGwx1/Nu0dcx
	 ll8IkAv2FRue+jawUIEbWuBH6tR/qJtz3RrgcL2zp5ntVN0PkHEPratYeDB5ndAId9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
	b=zw9dRDEyTlSBhjM9CpLsAVYfvB+TPgiCDqfiftRgbhR0YgFOs7+etA23Dfop/XgXgRUY
	 /K68XZTextPcwePKmmR549z9gvR5hhocla1bHvZ9Ao0qiT4HyMUEsxX+nOTm4ZoJQEMXY
	 tB+0Lsc3IoQ45mRpg9gxVI6qLU/7k+aTDcJ3G57Rrqn7b8lGfvaAQLVRsIEv7Wfyllbpj
	 RYqRtPnYLiOtvTjAe2ZnkSAyJoJEWWqVPDJ2vbe6Mh282Gbj0WvPTJRBy9bGr8/QPk4G8
	 g2q24rE/9W1YdxoSeP6jC+QF8P0sI75rEi0swTZUcVc3EfdGd1yXIOFylvl1ZrVdVLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVukFut1;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B9606A31B
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 02:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 969B9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVukFut1
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so172524a91.3
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 18:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793757882; x=1794362682; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
        b=CVukFut1wGnn0J6yeRxmutpIpk9xSbFOAN+U0VAO4hU3eEXSuGJHCtpZudYuS/9h8n
         o0rWr2oZcbxf8+D2OBe/F9eyE19y1THpgghHiagp4xLspGFVlzJUDlEgMZl4DJDaMfCZ
         7hlYbW+1XXBgSHtYVVotGfPuySLWIUelMYtV45E7EIZLN+wNsaWIP7crCrmXKcePonDX
         hYvRI4pMuYixHGgdLZ/c8MlPdCwFWxyDAf31zyAMiUkBM6o/X/w8AFqPe7bK7Xa51o9n
         je0/JgSyjl8nG1/rKOgWcmBMIeba3jHVTL4yGzVbKKaS57W7RjptvHXiKmF+QjDdFeP/
         69Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757882; x=1794362682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5DyPuoQ2QtooVZJkj1fmVXJYWMukRTdT9UmVFgbpUc=;
        b=TK+eLDZO9u7QbuvPCqyHkSl11YUiVjgm6W33qvvzTd+jR5Jte2x6jIQSfSnxm+OPO5
         l4IBVXhzCjLaQOWAQcQ8AYScfGsG9EtjPvvsTntRCprJyNAIwhw8e+QvgwI9sFzUfMnO
         hsbqYqOcS+4hkIX4sBWx/gClnrU/b5I1XbFRSJ53B9C9OLKY7W85r8xV5QjZfaGM9tZy
         RbyzNK8xxKs4H7x/DvteKI16s31XRVbKnG4aGkzSBQBEuqE3TcinKfDxmNhwV8fsNnxK
         0M+bQoudcPy0DuRiYdNebW6ZvAsrh7zLa8p/GGH9jgemE6NP+UTew88aMyBFe5jp91h8
         tdWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtiy40dtP52WUQrslWS0wpQffcBBme3zcmvSlNb/RQ53EtBnCnSfwdPsux3PhVBYHG+AM8Wg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sRUx3XAZkbI2L3Et+POf5C43G29Q7YbrzwxRWpcBsxKWXqy/7
	GBgBu/Ceh6WX/jf18gsOBxNQWBnW3jso6qwKxWTmGU4m68coNylP+QzN
X-Gm-Gg: AYBFou03KgH9bpS/OaU+LCxF/S4loksv+QE16rR3bBtMlFHGZohfbVCS1HzT7a7aFMH
	h3S1j4buthl5vagRA1lGCt1Bz6BXqq6XKdwnb9fdgX/Tx87b12ds/8wTEtg4vPQHLNPD1DL/Rky
	abxFpjnOYhxp0AXJ8j0GFvaAMD5Ua3ak2gmxib14b1o1RCUdN6X7C31lcg7pENhU1C4FUsH6ZhH
	GGCTIPt+CD+53njclRKrI2zK+s+FHO3UXNPXz20zaaU1Q+UJYmmYaBotF3d3N37IIFOVv8jQWMg
	dYZkez/SoSIxcM0MroLyhDL7Iy/9PxrKjMaR6RvfP4QKYph6YxfAvWpYguyAfs6YMJVGfcN+K12
	YnZZlK6gzfC96ek9zKAR78W2IDqfLgk5WQCleHXYnJ4hiAFHvwyTiBx8fNOXmk96NI+gvGwNINr
	0tW/VS6kDOtDrqtQX17/Hrf43nDvZz/qaw1GBuebsOY/E1ad+XiY5Fo2//SVDbXVUe9wI7DCSNA
	qevqrwEcanbwk4rNAHjdZj/X1jXhzU1D1csNIPnkrwVbVZM1jgP6xJ9sSLip2vccdONdkAhztX2
	cDRo7Wv7vAVELj8ODaVYZMckaCK83yM/IYHgXHSjI97lZ1IJcsXsUmlcLaaiTfchRLhgfdw96/f
	3CvAAeKy8M8O5HEg6GagHAM3sSXEVdmiTQg==
X-Received: by 2002:a17:90b:48d0:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3ae8983c697mr11675852a91.43.1793757882013;
        Tue, 03 Nov 2026 18:04:42 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944bb7d0sm1356275a91.11.2026.11.03.18.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:04:41 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:04:40 +0000
Message-Id: <DMM23MFOQ7ZL.3P1ZUMR0MKVEM@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <davem@davemloft.net>,
 <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <kuniyu@google.com>, <willemb@google.com>,
 <matttbe@kernel.org>, <mptcp@lists.linux.dev>, <mason@kernel.org>,
 <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <netdev-bot+sashiko@kernel.org>
In-Reply-To: <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <179374187706.488855.8366350890804573396@kernel.org> <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com> <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 05:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> The log of patch 13 says that a cork is not safe for two senders.
>> Jiayuan proposed to serialize the senders in the reply to that patch.
>
>
> I will pick up thoes pre-existing issues and organize others reported by sashiko.

Thanks, but make sure to create reproducers for all sashiko findings.
Most of them are wrong.

I'm waiting for netdev maintainers to ack net/core/ bits.
