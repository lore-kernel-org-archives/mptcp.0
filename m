Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190531;
	b=w3n8u5FEMqKh8BQ0fRYAAzhqgFEHwoD+6Mf0ZO/teRjOmVrY45pExU/d843iVPSNsAFK
	 ig/4IVQA9NWPpMa6jIgNH0la0TLAGCQMs8VSNFO44M3aojTpLzk4GpRvmVAFsvXfjk12M
	 ec2lRjcAv8sFrKom/BFqOCdIK6FAHYFNACuncNhquMH31X+I7k7/GGflF9kjdaRKlOYr4
	 C+QOuk3QamzFk2Lo9j/2N2sD4fNO7doZIBuFjuupCdQ6tRUJpY/6ER6USDLIciy1OJY92
	 Dnep9/0ZGtw/MkDkj/xhHjS/xpS+dPdk2yIn3i9txa4U+ZBOdIUEi/fmIv7r038fV+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=KJSZkI2FhEFh4W93ka8Ob6POsXG47krNnlt+BOygAhg=;
	b=1Cm+ywn8bc7ABm+jV6z1mw8gmJCzquLOLnsNOLHigIB4NeS3/H2QYjRqPB/kIvq6OM8u
	 Q5Rqz9CC0jdb9GJW1L7H0kp4QVYl5b5nQsuGffJD4GnsGB+quN9UnHBKUwlm8hwnIJWGs
	 12ue9qIRTN3eWOA+E6iC579/DCRKA4y4NzGwGIyYZlPcboU4pA3a7O8X85Bie0eDno2Z3
	 pbDhYtE7r5+LdQx58+3WRxO8yv8uwoAo4xaHy/NSwKPV/VujqUeuQpw3XNrDfFfwVphqd
	 MhzNwrpM5W+paeFati1dEGg7KAg9vcIfc5zVCKQJ+4Jbn3oPci5bm//taBTSmqiC/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xl/qUpOG";
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC3606A31C
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 12:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57BC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xl/qUpOG
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1afdf5196so362431eaf.2
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793190530; x=1793795330; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KJSZkI2FhEFh4W93ka8Ob6POsXG47krNnlt+BOygAhg=;
        b=Xl/qUpOGwLr01KJ7D2gS3GYJVpAiDeo1Wqxge7w0lqIJX/SZ0yXjX5E+nThy6CwkRS
         XSQAobwTrUDtHG5YC8WIgdbQ4VGi9d+rkU5b+2ozYEguh1Xdudr2aYPuDELZhKmldwjP
         asyX3JBRQH8r9KTnF04OwWVhC8Ve6uWfHLudLShCFmcwKYkEDY4snk1YAo3iQSzBMBXB
         8SyatX6TD7EYPu10Dx2Zfu8Z6K5A7WoE5+NHbiuME4mqzLgXz4CrxNNAPmSZQ5HZTMXu
         r7/D43l9o9ajr+2HPXbYJQdCoF+R4hZZs8asB7vpivaSn/uQ/mKOX05fp8pFu1cZ9ZAq
         YBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793190530; x=1793795330;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJSZkI2FhEFh4W93ka8Ob6POsXG47krNnlt+BOygAhg=;
        b=J/WEIeDSJnd4uscpVSrymnrY8rl5k89L04owX0GPN4zkjEO/Ode+vV4a8jIcr/2nbW
         R0IRkJSVxqj8EHQgxkkcoXhv73F/WlbircPa32KIG4Y+F/3Syixhv2SeZ8N8RnPp/47t
         xAe8lS4GwJ+rMUScjqB3bQxLWN2hJS8KjDO0E3zqfzN8AbFnNrbKU67Dr36bmbkJgKDO
         NfBFjpoHoyPjUCjW3LjC2I0L0ADyqKctG8N4DAP+2skSwJuL8QqOSkwFGtDsHkEi143r
         AeHRyB8J0Q6JZwA2FBSBiOQIALRPtJo3iHeJmAk6dGiBVlbcGScOEqSchGGJc3GEWelf
         UTwQ==
X-Gm-Message-State: AFq9FYKEbbEaYFKuFcBekg0vlOwwDxbHm5nSSqawOjM+bWQWyxXAqKkJ
	FTYu1vgDi/oYaiKW3SdLOa/VeFXHGALomQXT3Dx9/ltrV/UP9NokhZA=
X-Gm-Gg: AYBFou074oSy9z4XWOaA7ak1uCbo0zJNL23rd2dBUfcEFuJaEVDTkY1x8noT559iqAu
	+1qn9ncZNsJo+1KyoZRoIqmj2nwitCEqdatTMpf0wW8JAQqQjKRlDlxPstrF9pFW71mc7V5v35I
	EnmTtSuQoKatGursQUoLk//fwt3tqUq6ywD3Q0lCV6HnsPiP+oh9kh3erjfWDaUM/EDja3SPije
	1Gt9ZGNEmgspYkesyN+0CPDcm5Hid0HIQb8z4tS1yrhugOH8TUMv5CmyFdObbV+95Po8qe9DSOO
	h+qy2jr2LIQ59MYPjXMjgHdXi4MoPaEYytX9Xy5EL/B1db6CptFjAIIc/2KmSA3JXiwxJYTs83W
	2VunDUJ+/GzQeL+YC37o8Yxbr62AgetwLPID5tkUvCaSLUjxXHghpidILHmj8qLeLTffc3JXrfn
	1qBS4ZN5GO29PcZlsa/Ka+wYGsp9+PdK7mcRrmkt5pqbwTZho1Iu0064EWyAUHO7WjyHO1PUxV8
	5Hccv0g0N/2E4CfZ/LF6DureYcFYK6a8UGpcYBtxp2Ac5epuoH82AdM4uz+BPGB4mEhgilNLvz4
	FAoOML5DacStpY3cubOzT9/7ZHSf9D6MNeeTjwPGO8M=
X-Received: by 2002:a05:6820:1355:b0:70d:8086:e48e with SMTP id 006d021491bc7-713ee766598mr1093419eaf.20.1793190530103;
        Wed, 28 Oct 2026 05:28:50 -0700 (PDT)
Received: from github.com ([40.124.248.247])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb765a3sm1351954eaf.4.2026.10.28.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:28:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
References:
 <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v5 0/4] mptcp: sched: penalise a slow
 subflow
Message-ID: <b5ab3efd-9661-8d7b-6549-49c62e5fee46@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 12:28:48 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40681247377

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6f660b55cc=
cf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1195344


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
