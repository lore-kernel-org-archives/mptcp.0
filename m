Content-Type: multipart/mixed; boundary="===============0134212274180090639=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC] net: mptcp: improve fallback after successful
 3-way-handshake
Date: Wed, 22 Apr 2020 15:53:37 +0200
Message-ID: <7606ab2761aa50987f553d6d838229638e09e5e7.camel@redhat.com>
In-Reply-To: 8e5fcbd2e3c6fbf90f6d836fa82de2ceed3298e2.1587490709.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4221

--===============0134212274180090639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[off-list, perche' vado di idee pazze per platea ristretta ;)]

On Tue, 2020-04-21 at 19:42 +0200, Davide Caratti wrote:
> @@ -663,6 +669,10 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
>  			ssk->sk_err =3D EBADMSG;
>  			goto fatal;
>  		}
> +		if (status =3D=3D MAPPING_INFINITE) {
> +			tcp_sk(ssk)->is_mptcp =3D 0;
> +			return false;
> +		}

Mi sovviene che bisogna anche impedire al PM di creare subflow
addizionali.

Idea pazza... ma se aggiungiano un flag a msk, 'fallback', che settiamo
qui ed in generale devo facciamo fallback (ma non subflow_syn_recv_sock
() perche' li' finiamo per restituire un socket tcp) e:

in =

mptcp_established_options() ->
	do nothing if (unlikely(msk->fallback))

in subflow_check_data_avail() -> =

	if (unlikely(msk->fallback)) {
		setta mappa valida per skb corrente
		return ok

possiamo rimuovere i casi speciali in recvmsg(),sendmsg(),poll()! -
spero :)

WDYT?!?

A prescindere c'e' un punto da gestire. In caso di fallback sul 4 ack,
adesso becchiamo:
	WARN_ON_ONCE(subflow->can_ack);
in check_fully_established() che probabilmente andrebbe tolto.

Lo raggiungiamo quando riceviamo come primo ack ai dati un paccketto
senza DATA_ACK - quindi forse possiamo usarlo per identificare il
fallback a TCP.

/P

--===============0134212274180090639==--
